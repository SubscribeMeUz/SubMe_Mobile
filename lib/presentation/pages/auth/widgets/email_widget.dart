import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';

class EmailWidget extends StatelessWidget {
  final String iconPath;
  final String text;
  final VoidCallback onTap;
  const EmailWidget({super.key, required this.iconPath, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: context.colors.borderColor),
        ),
        child: Row(
          children: [
            SvgPicture.asset(iconPath, height: 24, width: 24),
            const Gap(64),
            Text(
              text,
              style: context.textStyle.sfProMedium.copyWith(color: context.colors.whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
