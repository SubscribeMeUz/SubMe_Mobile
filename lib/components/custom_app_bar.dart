import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gym_pro/assets/assets.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? titleText;
  final double leadingWidth;
  final Widget? leading;
  final List<Widget>? actions;
  const CustomAppBar({
    super.key,
    this.titleText,
    this.leadingWidth = 40,
    this.leading,
    this.actions,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colors.backgroundColor,
      title:
          widget.titleText != null
              ? Text(
                widget.titleText!,
                style: context.textStyle.sfProBold.copyWith(color: context.colors.whiteColor),
              )
              : null,

      centerTitle: true,
      leadingWidth: widget.leadingWidth,
      leading:
          widget.leading ??
          (Navigator.canPop(context)
              ? IconButton(
                iconSize: 24,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset(Assets.svgChevronLeft),
              )
              : null),
      actions: widget.actions,
    );
  }
}
