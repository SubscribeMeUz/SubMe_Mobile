import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:gym_pro/assets/assets.dart';
import 'package:gym_pro/components/dot_widget.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';

class GymTitleWidget extends StatelessWidget {
  const GymTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        'https://landmarksarchitects.com/wp-content/uploads/2024/04/Functionality-and-Space-Planning-03.04.2024.jpg',
                      ),
                    ),
                  ),
                ),
                Text(
                  'Lemon Gym',
                  style: context.textStyle.sfProSemiBold.copyWith(
                    fontSize: 20,
                    height: 25 / 20,
                    color: context.colors.whiteColor,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: context.colors.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '-30%',
                style: context.textStyle.sfProRegular.copyWith(color: context.colors.blackColor),
              ),
            ),
          ],
        ),
        const Gap(16),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          decoration: BoxDecoration(
            color: context.colors.cardDark,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              SvgPicture.asset(Assets.svgRate),
              const Gap(4),
              Text(
                '4.8',
                style: context.textStyle.sfProRegular.copyWith(
                  color: context.colors.whiteColor,
                  fontSize: 15,
                  height: 16 / 14,
                ),
              ),
              const Gap(4),
              DotWidget(),
              const Gap(6),
              Text(
                '1200 reviews',
                style: context.textStyle.sfProRegular.copyWith(
                  color: context.colors.whiteColor,
                  fontSize: 15,
                  height: 16 / 14,
                ),
              ),

              const Gap(4),
              DotWidget(),
              const Gap(6),
              Text(
                'GYM',
                style: context.textStyle.sfProRegular.copyWith(
                  color: context.colors.whiteColor,
                  fontSize: 15,
                  height: 16 / 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
