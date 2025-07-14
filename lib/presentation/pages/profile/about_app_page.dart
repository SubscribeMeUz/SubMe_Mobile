import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:gym_pro/assets/assets.dart';
import 'package:gym_pro/components/custom_app_bar.dart';
import 'package:gym_pro/config/mixin/get_version_mixin.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutAppPage extends StatefulWidget {
  const AboutAppPage({super.key});

  @override
  State<AboutAppPage> createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> with VersionMixin {
  _socialItem(BuildContext context, String assetName, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 41, vertical: 16),
        decoration: BoxDecoration(
          color: context.colors.cardDark,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SvgPicture.asset(assetName),
      ),
    );
  }

  String? version = '';

  @override
  void initState() {
    super.initState();
    getVersion();
  }

  void getVersion() async {
    version = await getAppVersion();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.blackColor,
      appBar: CustomAppBar(titleText: 'About the app'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(56),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36),
                  border: Border.all(color: Colors.white24, width: 1),
                  image: DecorationImage(image: AssetImage(Assets.coverLogo), fit: BoxFit.cover),
                ),
                child: SizedBox(width: 160, height: 160),
              ),
            ),
            const Gap(38),
            Text(
              'Mobile Application – SubMe',
              style: context.textStyle.sfProSemiBold.copyWith(
                color: context.colors.whiteColor,
                fontSize: 24,
                height: 24 / 22,
              ),
            ),
            const Gap(10),
            Text(
              'version: $version',
              style: context.textStyle.sfProRegular.copyWith(
                color: context.colors.whiteColor,
                fontSize: 16,
                height: 22 / 16,
              ),
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                '''
            SubMe is your personal subscription manager. The app helps you keep all your subscriptions — such as learning centers, coffee shops, fitness clubs, services, and more — in one place.
            
            Track your subscriptions, get reminders for upcoming payments. With SubMe, you stay organized and in control of your spending.''',
                style: context.textStyle.sfProRegular.copyWith(
                  color: context.colors.whiteColor,
                  fontSize: 16,
                  height: 22 / 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Gap(38),
            _socialItem(context, Assets.svgTelegram, () {
              launchUrlString('https://t.me/SubscribeMeUz');
            }),
          ],
        ),
      ),
    );
  }
}
