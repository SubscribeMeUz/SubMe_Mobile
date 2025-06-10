import 'package:flutter/material.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String buttonText;
  const CustomButton({super.key, required this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: onTap != null ? context.colors.primaryColor : context.colors.disabledButtonColor,
        ),
        child: Center(
          child: Text(
            buttonText,
            style: context.textStyle.sfProMedium.copyWith(fontSize: 17, color: Color(0xff090909)),
          ),
        ),
      ),
    );
  }
}
