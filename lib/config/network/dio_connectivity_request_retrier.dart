import 'dart:async';

import 'package:dio/dio.dart';
import 'package:gym_pro/config/utils/connection_checker.dart';

class DioConnectivityRequestRetrier {
  final Dio dio;

  DioConnectivityRequestRetrier({required this.dio});

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    late StreamSubscription streamSubscription;
    final responseCompleter = Completer<Response>();

    // streamSubscription = internetConnection.onStatusChange.listen(
    streamSubscription = DataConnectionChecker().onStatusChange.listen((connectivityResult) async {
      // if (connectivityResult != InternetStatus.disconnected) {
      if (connectivityResult != DataConnectionStatus.disconnected) {
        streamSubscription.cancel();
        // Complete the completer instead of returning
        responseCompleter.complete(
          dio.request(
            requestOptions.path,
            cancelToken: requestOptions.cancelToken,
            data: requestOptions.data,
            onReceiveProgress: requestOptions.onReceiveProgress,
            onSendProgress: requestOptions.onSendProgress,
            queryParameters: requestOptions.queryParameters,
            options: Options(
              contentType: requestOptions.contentType,
              method: requestOptions.method,
              responseType: requestOptions.responseType,
              sendTimeout: requestOptions.sendTimeout,
              receiveTimeout: requestOptions.receiveTimeout,
              headers: requestOptions.headers,
              extra: requestOptions.extra,
              validateStatus: requestOptions.validateStatus,
              receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
              followRedirects: requestOptions.followRedirects,
              maxRedirects: requestOptions.maxRedirects,
              requestEncoder: requestOptions.requestEncoder,
              responseDecoder: requestOptions.responseDecoder,
              listFormat: requestOptions.listFormat,
              persistentConnection: requestOptions.persistentConnection,
              preserveHeaderCase: requestOptions.preserveHeaderCase,
            ),
          ),
        );
      }
    });
    return responseCompleter.future;
  }
}
