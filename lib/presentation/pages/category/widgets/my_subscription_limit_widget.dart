import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:gym_pro/domain/entity/my_subscription_entity.dart';
import 'package:intl/intl.dart';

class MySubscriptionLimitWidget extends StatelessWidget {
  final MySubscriptionEntity entity;
  const MySubscriptionLimitWidget({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _LimitWidget(leftCount: entity.leftCount, totalCount: entity.totalCount),
        const Gap(16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${entity.leftDays} days',
                style: context.textStyle.sfProMedium.copyWith(
                  color: context.colors.primaryColor,
                  fontSize: 17,
                ),
              ),
              if (entity.startDate != null)
                _item(context, 'Activated', DateFormat.yMMMMd().format(entity.startDate!)),
              if (entity.finishDate != null)
                _item(context, 'Expire date', DateFormat.yMMMMd().format(entity.finishDate!)),
            ],
          ),
        ),
      ],
    );
  }

  _item(BuildContext context, String title, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textStyle.sfProMedium.copyWith(
            color: context.colors.whiteColor,
            fontSize: 16,
          ),
        ),
        Text(
          value,
          style: context.textStyle.sfProRegular.copyWith(
            fontSize: 14,
            color: context.colors.grayDarkColor,
          ),
        ),
      ],
    );
  }
}

class _LimitWidget extends StatelessWidget {
  final int totalCount;
  final int leftCount;

  const _LimitWidget({required this.totalCount, required this.leftCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),

      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.colors.blackColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$leftCount visits out of $totalCount',
            style: context.textStyle.sfProSemiBold.copyWith(
              color: context.colors.whiteColor,
              fontSize: 16,
            ),
          ),
          const Gap(8),
          Container(
            height: 8,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: context.colors.containerDark,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.colors.primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: SizedBox(width: 60, height: 8),
            ),
          ),
          const Gap(8),
          Text(
            'Left here this month',
            style: context.textStyle.sfProRegular.copyWith(
              color: context.colors.grayDarkColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
