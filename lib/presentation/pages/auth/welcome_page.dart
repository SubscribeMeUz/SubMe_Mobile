import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_pro/assets/assets.dart';
import 'package:gym_pro/components/bottom_button_bar.dart';
import 'package:gym_pro/components/custom_button.dart';
import 'package:gym_pro/config/localisation/app_localisation.dart';
import 'package:gym_pro/config/localisation/localisation_keys.dart';
import 'package:gym_pro/config/router/route_name.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:gym_pro/presentation/bloc/app_settings/app_settings_cubit.dart';
import 'package:gym_pro/presentation/pages/auth/widgets/email_widget.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomButtonBar(
        widgetBelowButton: BlocBuilder<AppSettingsCubit, AppSettingsState>(
          buildWhen: (previous, current) => previous.locale != current.locale,
          builder: (context, state) {
            return RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: context.textStyle.sfProMedium.copyWith(
                  color: context.colors.disabledColor.withAlpha(70),
                  fontSize: 14,
                ),
                children: [
                  TextSpan(text: '${context.tr(LocalisationKeys.sign_accept)} '),
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    text: ' ${context.tr(LocalisationKeys.user_agreement)} ',
                    style: context.textStyle.sfProMedium.copyWith(
                      color: context.colors.whiteColor,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(text: context.tr(LocalisationKeys.and)),
                  TextSpan(
                    text: ' ${context.tr(LocalisationKeys.privacy_policy)}',
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    style: context.textStyle.sfProMedium.copyWith(
                      color: context.colors.whiteColor,
                      fontSize: 14,
                    ),
                  ),
                  if (state.locale == 'uz')
                    TextSpan(
                      text: context.tr(LocalisationKeys.agreement_accept),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                      style: context.textStyle.sfProMedium.copyWith(
                        color: context.colors.whiteColor,
                        fontSize: 14,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Gap(32),
            Image.asset(Assets.welcomePng),
            const Gap(24),
            Text(
              'My Subscriptions',
              style: context.textStyle.sfProBold.copyWith(
                color: context.colors.whiteColor,
                fontSize: 34,
              ),
            ),
            Text(
              'all your subscriptions in one app',
              style: context.textStyle.sfProMedium.copyWith(
                color: context.colors.disabledColor.withAlpha(70),
                fontSize: 17,
              ),
            ),
            const Gap(32),
            CustomButton(
              onTap: () {
                context.goNamed(RouteName.enterPhoneRoute);
              },
              buttonText: 'Start',
            ),
            const Gap(12),
            EmailWidget(iconPath: Assets.appleLogo, text: 'Continue with Apple', onTap: () {}),
            const Gap(12),
            EmailWidget(iconPath: Assets.gmailLogo, text: 'Continue with Google', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
