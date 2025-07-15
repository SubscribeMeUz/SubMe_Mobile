import 'package:package_info_plus/package_info_plus.dart';

mixin VersionMixin {
  Future<String> getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return 'v${packageInfo.version}+${packageInfo.buildNumber}';
  }
}
