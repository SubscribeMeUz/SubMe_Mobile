import 'package:go_router/go_router.dart';
import 'package:gym_pro/config/cache/cache_keys.dart';
import 'package:gym_pro/config/cache/local_storage.dart';
import 'package:gym_pro/config/router/route_name.dart';
import 'package:gym_pro/config/router/router.dart';

mixin LogoutMixin {
  Future<void> logout({bool navigateToAuth = true}) async {
    final language = LocalStorage.getString(CacheKeys.locale, defValue: 'en');
    await LocalStorage.clearStorage();
    await LocalStorage.putString(CacheKeys.locale, language);

    if (navigateToAuth) {
      rootNavigatorKey.currentContext?.goNamed(RouteName.welcomeRoute);
    }
  }
}
