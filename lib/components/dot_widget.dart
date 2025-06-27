import 'package:flutter/cupertino.dart';
import 'package:gym_pro/config/style/app_colors.dart';

class DotWidget extends StatelessWidget {
  final Color? backgroundColor;
  final double? width;
  final double? height;

  const DotWidget({super.key, this.backgroundColor, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 4,
      height: height ?? 4,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? context.colors.whiteColor,
      ),
    );
  }
}
