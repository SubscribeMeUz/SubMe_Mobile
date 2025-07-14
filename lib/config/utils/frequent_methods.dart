import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:intl/intl.dart';

class FrequentMethods {
  static String phoneFormatter(String phone) {
    phone = phone.replaceAll('+', '').replaceAll(' ', '').trim();
    if (phone.length == 12) {
      return '+${phone.substring(0, 3)} ${phone.substring(3, 5)} ${phone.substring(5, 8)} ${phone.substring(8, 10)} ${phone.substring(10, 12)}';
    }
    if (phone.length == 9) {
      return '+998 ${phone.substring(3, 5)} ${phone.substring(5, 8)} ${phone.substring(8, 10)} ${phone.substring(10, 12)}';
    }
    return '';
  }

  static String moneyFormat(num? number) {
    var localNumber = number;
    if (localNumber == null) return '0';
    final isNegative = localNumber.isNegative;
    localNumber = localNumber.abs();
    var result = '0';
    result = NumberFormat().format(localNumber);
    return isNegative ? '-$result' : result;
  }

  static void showSnackBar(
    BuildContext context,
    String text, {
    Color color = Colors.red,
    Duration? duration,
  }) {
    final snackBar = SnackBar(
      content: Text(
        text,
        // style: context.textStyle.montSemiBold12.copyWith(fontSize: 16)
      ),
      duration: duration ?? const Duration(milliseconds: 3000),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showAlertDialog(
    BuildContext context,
    String title,
    String subtitle, {
    VoidCallback? onYesTap,
    VoidCallback? onNoTap,
    String? yesButtonText,
    String? noButtonText,
  }) {
    showCupertinoDialog<void>(
      context: context,
      builder:
          (BuildContext context) => CupertinoTheme(
            data: CupertinoThemeData(brightness: Brightness.dark),
            child: CupertinoAlertDialog(
              title: Text(
                title,
                style: context.textStyle.sfProSemiBold.copyWith(
                  fontSize: 18,
                  color: context.colors.whiteColor,
                ),
              ),
              content: Text(
                subtitle,
                style: context.textStyle.sfProRegular.copyWith(
                  fontSize: 14,
                  color: context.colors.grayDarkColor,
                ),
              ),
              actions: <CupertinoDialogAction>[
                if (onNoTap != null || noButtonText != null)
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    onPressed: () {
                      Navigator.pop(context);
                      if (onNoTap != null) {
                        onNoTap();
                      }
                    },
                    child: Text(
                      noButtonText ?? 'No',
                      style: context.textStyle.sfProSemiBold.copyWith(
                        color: context.colors.whiteColor,
                      ),
                    ),
                  ),

                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                    if (onYesTap != null) {
                      onYesTap();
                    }
                  },
                  child: Text(
                    yesButtonText ?? 'OK',
                    style: context.textStyle.sfProSemiBold.copyWith(
                      color: context.colors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
