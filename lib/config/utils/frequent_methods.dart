import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FrequentMethods {
  static String phoneFormatter(String phone) {
    if (phone.length == 13) {
      return '+ ${phone.substring(1, 4)} ${phone.substring(4, 6)} ${phone.substring(6, 9)} ${phone.substring(9, 11)} ${phone.substring(11, 13)}';
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
}
