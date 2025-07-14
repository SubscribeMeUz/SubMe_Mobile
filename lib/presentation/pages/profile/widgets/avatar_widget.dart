import 'package:flutter/material.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';

class AvatarWidget extends StatelessWidget {
  final String letter;
  const AvatarWidget({super.key, required this.letter});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xff242629)),
      child: Center(
        child: Text(
          letter,
          style: context.textStyle.sfProBold.copyWith(
            fontSize: 20,
            color: context.colors.whiteColor,
          ),
        ),
      ),
    );
  }
}
