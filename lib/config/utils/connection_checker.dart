import 'dart:io';
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

Future isInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult.contains(ConnectivityResult.mobile)) {
    // I am connected to a mobile network, make sure there is actually a net connection.

    if (await DataConnectionChecker().hasConnection) {
      // Mobile data detected & internet connection confirmed.
      return true;
    } else {
      // Mobile data detected but no internet connection found.
      return false;
    }
  } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
    // I am connected to a WIFI network, make sure there is actually a net connection.
    if (await DataConnectionChecker().hasConnection) {
      // Wifi detected & internet connection confirmed.
      return true;
    } else {
      // Wifi detected but no internet connection found.
      return false;
    }
  } else {
    // Neither mobile data or WIFI detected, not internet connection found.
    return false;
  }
}

enum DataConnectionStatus { disconnected, connected }

class DataConnectionChecker {
  static const int defaultPORT = 53;

  static const Duration defaultTIMEOUT = Duration(seconds: 5);

  static const Duration defaultINTERVAL = Duration(seconds: 5);

  static final List<AddressCheckOptions> defaultADDRESSES = List.unmodifiable([
    AddressCheckOptions(InternetAddress('1.1.1.1'), port: defaultPORT, timeout: defaultTIMEOUT),
    AddressCheckOptions(
      InternetAddress('8.8.4.4'), // google
      port: defaultPORT,
      timeout: defaultTIMEOUT,
    ),
    AddressCheckOptions(
      InternetAddress('208.67.222.222'), // opendns
      port: defaultPORT,
      timeout: defaultTIMEOUT,
    ),
  ]);

  List<AddressCheckOptions> addresses = defaultADDRESSES;

  factory DataConnectionChecker() => _instance;
  DataConnectionChecker._() {
    _statusController.onListen = () {
      _maybeEmitStatusUpdate();
    };
    // stop sending status updates when no one is listening
    _statusController.onCancel = () {
      _timerHandle?.cancel();
      _lastStatus = null; // reset last status
    };
  }
  static final DataConnectionChecker _instance = DataConnectionChecker._();

  /// Ping a single address. See [AddressCheckOptions] for
  /// info on the accepted argument.
  Future<AddressCheckResult> isHostReachable(AddressCheckOptions options) async {
    Socket? sock;
    try {
      sock = await Socket.connect(options.address, options.port, timeout: options.timeout);
      sock.destroy();
      return AddressCheckResult(options, true);
    } catch (e) {
      sock?.destroy();
      return AddressCheckResult(options, false);
    }
  }

  /// Returns the results from the last check.
  ///
  /// The list is populated only when [hasConnection]
  /// (or [connectionStatus]) is called.
  List<AddressCheckResult> get lastTryResults => _lastTryResults;
  List<AddressCheckResult> _lastTryResults = <AddressCheckResult>[];

  /// Initiates a request to each address in [addresses].
  /// If at least one of the addresses is reachable
  /// we assume an internet connection is available and return `true`.
  /// `false` otherwise.
  Future<bool> get hasConnection async {
    List<Future<AddressCheckResult>> requests = [];

    for (var addressOptions in addresses) {
      requests.add(isHostReachable(addressOptions));
    }
    _lastTryResults = List.unmodifiable(await Future.wait(requests));

    return _lastTryResults.map((result) => result.isSuccess).contains(true);
  }

  /// Initiates a request to each address in [addresses].
  /// If at least one of the addresses is reachable
  /// we assume an internet connection is available and return `true`
  /// [DataConnectionStatus.connected].
  /// [DataConnectionStatus.disconnected] otherwise.
  Future<DataConnectionStatus> get connectionStatus async {
    return await hasConnection ? DataConnectionStatus.connected : DataConnectionStatus.disconnected;
  }

  /// Defaults to [DEFAULT_INTERVAL] (10 seconds).
  Duration checkInterval = defaultINTERVAL;

  _maybeEmitStatusUpdate([Timer? timer]) async {
    // just in case
    _timerHandle?.cancel();
    timer?.cancel();

    var currentStatus = await connectionStatus;

    if (_lastStatus != currentStatus && _statusController.hasListener) {
      _statusController.add(currentStatus);
    }

    // start new timer only if there are listeners
    if (!_statusController.hasListener) return;
    _timerHandle = Timer(checkInterval, _maybeEmitStatusUpdate);

    // update last status
    _lastStatus = currentStatus;
  }

  // _lastStatus should only be set by _maybeEmitStatusUpdate()
  // and the _statusController's.onCancel event handler
  DataConnectionStatus? _lastStatus;
  Timer? _timerHandle;

  // controller for the exposed 'onStatusChange' Stream
  final StreamController<DataConnectionStatus> _statusController = StreamController.broadcast();

  /// Subscribe to this stream to receive events whenever the
  /// [DataConnectionStatus] changes. When a listener is attached
  /// a check is performed immediately and the status ([DataConnectionStatus])
  /// is emitted. After that a timer starts which performs
  /// checks with the specified interval - [checkInterval].
  /// Default is [DEFAULT_INTERVAL].
  ///
  /// *As long as there's an attached listener, checks are being performed,
  /// so remember to dispose of the subscriptions when they're no longer needed.*
  ///
  /// Example:
  ///
  /// ```dart
  /// var listener = DataConnectionChecker().onStatusChange.listen((status) {
  ///   switch(status) {
  ///     case DataConnectionStatus.connected:
  ///       print('Data connection is available.');
  ///       break;
  ///     case DataConnectionStatus.disconnected:
  ///       print('You are disconnected from the internet.');
  ///       break;
  ///   }
  /// });
  /// ```
  ///
  /// *Note: Remember to dispose of any listeners,
  /// when they're not needed anymore,
  /// e.g. in a* `StatefulWidget`'s *dispose() method*
  ///
  /// ```dart
  /// ...
  /// @override
  /// void dispose() {
  ///   listener.cancel();
  ///   super.dispose();
  /// }
  /// ...
  /// ```
  ///
  /// For as long as there's an attached listener, requests are
  /// being made with an interval of `checkInterval`. The timer stops
  /// when an automatic check is currently executed, so this interval
  /// is a bit longer actually (the maximum would be `checkInterval` +
  /// the maximum timeout for an address in `addresses`). This is by design
  /// to prevent multiple automatic calls to `connectionStatus`, which
  /// would wreck havoc.
  ///
  /// You can, of course, override this behavior by implementing your own
  /// variation of time-based checks and calling either `connectionStatus`
  /// or `hasConnection` as many times as you want.
  ///
  /// When all the listeners are removed from `onStatusChange`, the internal
  /// timer is cancelled and the stream does not emit events.
  Stream<DataConnectionStatus> get onStatusChange => _statusController.stream;

  /// Returns true if there are any listeners attached to [onStatusChange]
  bool get hasListeners => _statusController.hasListener;

  /// Alias for [hasListeners]
  bool get isActivelyChecking => _statusController.hasListener;
}

/// This class should be pretty self-explanatory.
/// If [AddressCheckOptions.port]
/// or [AddressCheckOptions.timeout] are not specified, they both
/// default to [DataConnectionChecker.DEFAULT_PORT]
/// and [DataConnectionChecker.DEFAULT_TIMEOUT]
/// Also... yeah, I'm not great at naming things.
class AddressCheckOptions {
  final InternetAddress address;
  final int port;
  final Duration timeout;

  AddressCheckOptions(
    this.address, {
    this.port = DataConnectionChecker.defaultPORT,
    this.timeout = DataConnectionChecker.defaultTIMEOUT,
  });

  @override
  String toString() => "AddressCheckOptions($address, $port, $timeout)";
}

/// Helper class that contains the address options and indicates whether
/// opening a socket to it succeeded.
class AddressCheckResult {
  final AddressCheckOptions options;
  final bool isSuccess;

  AddressCheckResult(this.options, this.isSuccess);

  @override
  String toString() => "AddressCheckResult($options, $isSuccess)";
}

class MyConnectivity {
  MyConnectivity._();

  static final _instance = MyConnectivity._();
  static MyConnectivity get instance => _instance;
  final _connectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;

  void initialise() async {
    List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    _checkStatus(result);
    _connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(List<ConnectivityResult> result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();
}
