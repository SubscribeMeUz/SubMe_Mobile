import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:gym_pro/config/localisation/app_localisation.dart';
import 'package:gym_pro/config/localisation/localisation_keys.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:gym_pro/presentation/pages/auth/widgets/timer_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ConfirmationUi extends StatefulWidget {
  final String? titleText;
  final String phoneNumber;
  final int otpLength;
  final void Function(String) onSubmit;
  final VoidCallback onResendCode;
  const ConfirmationUi({
    super.key,
    this.titleText,
    required this.phoneNumber,
    this.otpLength = 5,
    required this.onSubmit,
    required this.onResendCode,
  });

  @override
  State<ConfirmationUi> createState() => _ConfirmationUiState();
}

class _ConfirmationUiState extends State<ConfirmationUi> {
  final pinController = TextEditingController();
  @override
  void initState() {
    super.initState();
    pinController.addListener(() {
      var text = pinController.text;
      var length = text.length;
      if (length == widget.otpLength) {
        FocusScope.of(context).unfocus();
        widget.onSubmit(text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Gap(16),
          Text(
            widget.titleText ?? context.tr(LocalisationKeys.enter_code),
            style: context.textStyle.sfProBold.copyWith(
              color: context.colors.whiteColor,
              fontSize: 28,
            ),
          ),
          const Gap(8),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: context.textStyle.sfProMedium.copyWith(
                color: context.colors.ebebf5Color.withAlpha(90),
                fontSize: 17,
              ),
              children: [
                TextSpan(text: context.tr(LocalisationKeys.verif_code_sent_to)),
                TextSpan(
                  text: ' \n${widget.phoneNumber}. ',
                  style: context.textStyle.sfProMedium.copyWith(
                    color: context.colors.whiteColor,
                    fontSize: 17,
                  ),
                ),
                TextSpan(text: context.tr(LocalisationKeys.check_sms)),
              ],
            ),
          ),
          const Gap(32),
          PinCodeTextField(
            appContext: context,
            enableActiveFill: true,
            autoFocus: true,
            length: widget.otpLength,
            beforeTextPaste: (pastedText) {
              if (pastedText == null) return false;
              if (pastedText.length != widget.otpLength) {
                return false;
              }
              try {
                int.parse(pastedText);

                return true;
              } catch (e) {
                return false;
              }
            },
            useHapticFeedback: true,
            cursorColor: context.colors.primaryColor,
            showCursor: true,
            inputFormatters: [
              LengthLimitingTextInputFormatter(widget.otpLength),
              FilteringTextInputFormatter.digitsOnly,
            ],
            controller: pinController,
            textStyle: context.textStyle.sfProBold.copyWith(
              color: context.colors.whiteColor,
              fontSize: 26,
            ),

            keyboardType: TextInputType.number,
            pinTheme: PinTheme(
              fieldHeight: 64,
              fieldWidth: 64,
              borderWidth: 1,
              activeColor: context.colors.primaryColor,
              selectedColor: context.colors.primaryColor,
              inactiveColor: context.colors.cardDark,

              inactiveFillColor: context.colors.cardDark,
              activeFillColor: context.colors.cardDark,
              selectedFillColor: context.colors.cardDark,
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const Gap(32),
          TimerWidget(onTap: widget.onResendCode, retryInterval: 60),
        ],
      ),
    );
  }
}
