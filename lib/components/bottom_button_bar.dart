import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gym_pro/components/custom_button.dart';
import 'package:gym_pro/config/style/app_colors.dart';

class BottomButtonBar extends StatelessWidget {
  final Widget? button;
  final Widget? widgetBelowButton;
  final String? buttonText;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  const BottomButtonBar({
    super.key,
    this.button,
    this.widgetBelowButton,
    this.buttonText,
    this.padding,
    this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final keyboard = MediaQuery.of(context).viewInsets.bottom;
    final safePadding = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: BoxDecoration(color: backgroundColor ?? context.colors.backgroundColor),
      padding:
          padding ??
          EdgeInsets.only(top: 12, left: 16, right: 16, bottom: keyboard + safePadding + 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (button != null)
            button!
          else if (buttonText != null)
            CustomButton(buttonText: buttonText ?? '', onTap: onTap),
          if (widgetBelowButton != null) ...[const Gap(12), widgetBelowButton!],
        ],
      ),
    );
  }
}
