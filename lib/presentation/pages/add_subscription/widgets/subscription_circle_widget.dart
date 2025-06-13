import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:gym_pro/assets/assets.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:gym_pro/domain/entity/subcription_entity.dart';

class SubscriptionCircleWidget extends StatelessWidget {
  final SubscriptionEntity entity;
  final void Function(int) onChoose;
  const SubscriptionCircleWidget({super.key, required this.entity, required this.onChoose});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChoose(entity.id);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: 104,
                height: 104,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  //TODO set default image if logo is null
                  image: DecorationImage(image: CachedNetworkImageProvider(entity.logoUrl ?? '')),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colors.primaryColor,
                    border: Border.all(color: context.colors.backgroundColor, width: 4),
                  ),

                  child: SvgPicture.asset(Assets.svgTick),
                ),
              ),
            ],
          ),
          const Gap(12),
          Text(
            entity.name,
            style: context.textStyle.sfProBold.copyWith(
              fontSize: 16,
              height: 20 / 16,
              color: context.colors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
