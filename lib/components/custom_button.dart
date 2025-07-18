import 'package:flutter/material.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';

enum ButtonType { primary, secondary }

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String buttonText;
  final ButtonType buttonType;
  final bool isLoading;
  const CustomButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.buttonType = ButtonType.primary,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    late final Color backgroundColor;
    late final Color textColor;
    if (buttonType == ButtonType.primary) {
      backgroundColor = context.colors.primaryColor;
      textColor = Color(0xff090909);
    } else {
      backgroundColor = context.colors.cardDark;
      textColor = context.colors.primaryColor;
    }
    return GestureDetector(
      onTap: isLoading == false ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: onTap != null ? backgroundColor : context.colors.disabledButtonColor,
        ),
        child: Center(
          child:
              isLoading
                  ? SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(color: textColor),
                  )
                  : Text(
                    buttonText,
                    style: context.textStyle.sfProMedium.copyWith(fontSize: 17, color: textColor),
                  ),
        ),
      ),
    );
  }
}
