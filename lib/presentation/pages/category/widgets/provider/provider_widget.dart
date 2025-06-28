import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:gym_pro/assets/assets.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:gym_pro/domain/entity/provider_entity.dart';

class ProviderWidget extends StatelessWidget {
  final ProviderEntity providerEntity;
  final VoidCallback onTap;
  const ProviderWidget({super.key, required this.providerEntity, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(providerEntity.logo),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Gap(12),
                Text(
                  providerEntity.name,
                  style: context.textStyle.sfProSemiBold.copyWith(
                    color: context.colors.whiteColor,
                    height: 22 / 17,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            SvgPicture.asset(Assets.svgChevronRight, height: 24, width: 24),
          ],
        ),
      ),
    );
  }
}
