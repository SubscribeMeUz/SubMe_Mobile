import 'package:gym_pro/config/cache/cache_keys.dart';
import 'package:gym_pro/config/cache/local_storage.dart';
import 'package:intl/intl.dart';

extension StringExtensions on String? {
  DateTime? toDateTime({String format = 'dd.MM.yyyy HH:mm:ss'}) {
    final locale = LocalStorage.getString(CacheKeys.locale, defValue: 'ru');

    var localFormat = format;
    if (this == null) {
      return null;
    }
    final date = this;
    if (date!.length == 10) {
      localFormat = 'dd.MM.yyyy';
    }
    try {
      return DateFormat(localFormat, locale).parse(this!).toLocal();
    } catch (e) {
      try {
        return DateTime.tryParse(this!)?.toLocal();
      } catch (e) {
        return null;
      }
    }
  }
}
