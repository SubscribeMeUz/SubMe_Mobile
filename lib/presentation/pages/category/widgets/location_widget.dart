import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:gym_pro/assets/assets.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';

class LocationWidget extends StatelessWidget {
  final bool needsPadding;
  final Color? textColor;
  const LocationWidget({super.key, this.needsPadding = true, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: needsPadding ? const EdgeInsets.symmetric(horizontal: 16.0) : EdgeInsets.zero,
      child: Column(
        children: [
          _item(
            context: context,
            svgPath: Assets.svgLocation,
            title: 'House 7, Yunusobod Street, Tashkent',
            textColor: textColor,
          ),
          const Gap(8),
          _item(context: context, svgPath: Assets.svgNavigation, title: '6.4 km from you'),
        ],
      ),
    );
  }

  Widget _item({
    required BuildContext context,
    required String svgPath,
    required String title,
    Color? textColor,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: SvgPicture.asset(
            svgPath,
            colorFilter: ColorFilter.mode(
              textColor ?? context.colors.grayDarkColor,
              BlendMode.srcIn,
            ),
          ),
        ),
        const Gap(4),
        Text(
          title,
          style: context.textStyle.sfProLight.copyWith(
            color: textColor ?? context.colors.grayDarkColor,
          ),
        ),
      ],
    );
  }
}
