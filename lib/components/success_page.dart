import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:gym_pro/components/bottom_button_bar.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';

class SuccessPageArgs {
  final String iconPath;
  final String title;
  final String subtitle;
  final String? buttonText;
  final Function(BuildContext) onSubmit;

  const SuccessPageArgs({
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.onSubmit,
    this.buttonText,
  });
}

class SuccessPage extends StatelessWidget {
  final SuccessPageArgs args;
  const SuccessPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO localisation
      bottomNavigationBar: BottomButtonBar(
        onTap: () {
          args.onSubmit(context);
        },
        buttonText: args.buttonText ?? 'Continue',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colors.primaryColor.withAlpha(20),
            ),
            child: SvgPicture.asset(args.iconPath, height: 68, width: 68),
          ),
          const Gap(32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              args.title,
              textAlign: TextAlign.center,
              style: context.textStyle.sfProBold.copyWith(
                color: context.colors.whiteColor,
                fontSize: 24,
              ),
            ),
          ),
          const Gap(4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              args.subtitle,
              textAlign: TextAlign.center,
              style: context.textStyle.sfProMedium.copyWith(
                color: context.colors.grayDarkColor,
                fontSize: 17,
                height: 24 / 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
