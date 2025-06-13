import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';

class AdWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final String imagePath;
  const AdWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: context.colors.primaryContainerDark,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textStyle.sfProMedium.copyWith(
                    fontSize: 17,
                    color: context.colors.whiteColor,
                  ),
                ),
                const Gap(2),
                Text(
                  subtitle,
                  style: context.textStyle.sfProRegular.copyWith(
                    fontSize: 14,
                    color: context.colors.ebebf5Color,
                  ),
                ),
              ],
            ),
          ),
          const Gap(8),
          Image.asset(imagePath, width: 64),
          const Gap(12),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colors.blackColor.withValues(alpha: 0.24),
            ),
            child: Icon(Icons.close, color: context.colors.whiteColor, size: 16),
          ),
        ],
      ),
    );
  }
}
