import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_pro/assets/assets.dart';
import 'package:gym_pro/components/custom_app_bar.dart';
import 'package:gym_pro/config/localisation/app_localisation.dart';
import 'package:gym_pro/config/localisation/localisation_keys.dart';
import 'package:gym_pro/config/router/route_name.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:gym_pro/presentation/bloc/user/user_bloc.dart';
import 'package:gym_pro/presentation/pages/home/widgets/ad_widget.dart';
import 'package:gym_pro/presentation/pages/profile/widgets/avatar_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state.userEntity == null) {
                return const SizedBox.shrink();
              }
              return GestureDetector(
                onTap: () async {
                  final isUpdated = await context.pushNamed<bool?>(
                    RouteName.editProfileRoute,
                    extra: state.userEntity,
                  );
                  if (isUpdated == true && context.mounted) {
                    context.read<UserBloc>().add(GetUserEvent());
                  }
                },
                child: Text(
                  context.tr(LocalisationKeys.edit),
                  style: context.textStyle.sfProRegular.copyWith(
                    color: context.colors.primaryColor,
                    fontSize: 17,
                  ),
                ),
              );
            },
          ),
          const Gap(16),
        ],
      ),
      body: ListView(
        children: [
          const Gap(48),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return Column(
                children: [
                  AvatarWidget(letter: state.userEntity?.fullName?.substring(0, 1) ?? ''),
                  const Gap(16),
                  Center(
                    child: Text(
                      state.userEntity?.fullName ?? '',
                      style: context.textStyle.sfProSemiBold.copyWith(
                        color: context.colors.whiteColor,
                        fontSize: 20,
                        height: 25 / 20,
                      ),
                    ),
                  ),
                  const Gap(4),
                  Center(
                    child: Text(
                      state.userEntity?.phone ?? '',
                      // '+998 (99) 090-09-98',
                      style: context.textStyle.sfProRegular.copyWith(
                        color: context.colors.ebebf5Color,
                        fontSize: 15,
                        height: 18 / 14,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const Gap(32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AdWidget(
              title: 'First Month — Free! 🎉',
              subtitle:
                  'Start your fitness journey today! Enjoy your first month as a gift with SubMe.',
              imagePath: Assets.coverLogo,
              onTap: () {},
            ),
          ),
          const Gap(12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: context.colors.cardDark,
              borderRadius: BorderRadius.circular(24),
            ),

            child: Column(
              children: [
                item(Assets.svgAboutApp, context.tr(LocalisationKeys.about_app), () {
                  context.goNamed(RouteName.aboutApp);
                }),
                item(Assets.svgQuestion, context.tr(LocalisationKeys.frequent_questions), () {}),
                item(Assets.svgAgreement, context.tr(LocalisationKeys.terms_agreement), () {
                  launchUrlString('https://subme.uz');
                }),
                item(Assets.svgPrivacy, context.tr(LocalisationKeys.privacy_policy), () {
                  launchUrlString('https://subme.uz/privacy-policy');
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  item(String svgIcon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8),
        child: Row(
          children: [
            SvgPicture.asset(
              svgIcon,
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(context.colors.whiteColor, BlendMode.srcIn),
            ),
            const Gap(18),
            Flexible(
              child: Text(
                title,
                style: context.textStyle.sfProMedium.copyWith(
                  fontSize: 17,
                  color: context.colors.whiteColor,
                  height: 22 / 17,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
