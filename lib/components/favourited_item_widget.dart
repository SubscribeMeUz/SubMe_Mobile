import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:gym_pro/domain/entity/favourite_entity.dart';

class FavouritedItemWidget extends StatelessWidget {
  final FavouriteEntity entity;

  final VoidCallback onTap;
  const FavouritedItemWidget({super.key, required this.entity, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 132,
        height: 137,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: context.colors.cardDark,
        ),
        child: Column(
          children: [
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: CachedNetworkImageProvider(entity.imagePath)),
              ),
            ),
            const Gap(7),
            Text(
              entity.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textStyle.sfProMedium.copyWith(
                fontSize: 14,
                color: context.colors.whiteColor,
              ),
            ),
            const Gap(4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '${entity.subtitle}\n',
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: context.textStyle.sfProRegular.copyWith(
                  fontSize: 12,
                  color: context.colors.grayDarkColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
