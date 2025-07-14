import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:gym_pro/domain/entity/my_subscription_entity.dart';
import 'package:intl/intl.dart';

class MyAbonementItemWidget extends StatelessWidget {
  final MySubscriptionEntity entity;

  const MyAbonementItemWidget({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(entity.logoUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(12),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entity.name,
                    style: context.textStyle.sfProMedium.copyWith(
                      fontSize: 17,
                      color: context.colors.whiteColor,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    '${entity.period} days',
                    style: context.textStyle.sfProMedium.copyWith(
                      fontSize: 14,
                      color: context.colors.ebebf5Color.withAlpha(80),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${entity.leftCount} / ${entity.totalCount}',
                style: context.textStyle.sfProMedium.copyWith(
                  fontSize: 17,
                  color: context.colors.whiteColor,
                ),
              ),

              const Gap(2),
              if (entity.finishDate != null)
                Text(
                  DateFormat.yMMMMd().format(entity.finishDate!),
                  style: context.textStyle.sfProRegular.copyWith(
                    fontSize: 14,
                    color: context.colors.ebebf5Color.withAlpha(80),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
