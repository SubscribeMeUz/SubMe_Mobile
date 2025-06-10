import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';

class TimerWidget extends StatefulWidget {
  final VoidCallback onTap;
  final int retryInterval;

  const TimerWidget({required this.onTap, required this.retryInterval, super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int seconds = 60;
  late Timer timer;

  @override
  void initState() {
    seconds = widget.retryInterval;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds != 0) {
        setState(() {
          seconds--;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (seconds == 0) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          widget.onTap();
          setState(() {
            seconds = widget.retryInterval;
          });
        },
        child: Text(
          'Resend code',
          style: context.textStyle.sfProMedium.copyWith(
            color: context.colors.primaryColor,
            fontSize: 17,
          ),
        ),
      );
    } else {
      return RichText(
        text: TextSpan(
          style: context.textStyle.sfProMedium.copyWith(
            color: context.colors.disabledColor.withAlpha(70),
            fontSize: 17,
          ),
          children: [
            TextSpan(text: 'We’ll resend in '),
            TextSpan(
              text: '$seconds second',
              style: context.textStyle.sfProMedium.copyWith(
                color: context.colors.whiteColor,
                fontSize: 17,
              ),
            ),
          ],
        ),
      );
    }
  }
}
