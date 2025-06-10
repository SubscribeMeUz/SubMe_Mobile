import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final bool obscureText;
  final bool isFocused;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType inputType;
  final String? prefixText;
  final TextEditingController controller;

  const CustomTextField({
    required this.labelText,
    required this.controller,
    this.inputType = TextInputType.name,
    this.obscureText = false,
    this.isFocused = false,
    super.key,
    this.inputFormatters,
    this.prefixText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      keyboardType: widget.inputType,
      autofocus: widget.isFocused,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        prefixText: widget.prefixText,
        hintText: widget.labelText,
        labelStyle: context.textStyle.robotoRegular.copyWith(
          fontSize: 16,
          color: Color(0xFF888888),
        ),
        hintStyle: context.textStyle.sfProRegular.copyWith(
          fontSize: 17,
          color: context.colors.disabledColor.withAlpha(70),
        ),
        prefixStyle: context.textStyle.sfProBold.copyWith(
          fontSize: 17,
          color: context.colors.whiteColor,
        ),
        filled: true,
        fillColor: context.colors.cardDark,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 17),
      ),
      style: context.textStyle.sfProMedium.copyWith(fontSize: 17, color: context.colors.whiteColor),
    );
  }
}
