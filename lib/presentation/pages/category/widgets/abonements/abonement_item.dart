import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:gym_pro/domain/entity/provider_abonements_entity.dart';

class AbonementItem extends StatelessWidget {
  final bool isHorizontal;
  final bool isChosen;
  final AbonementOptionEntity option;
  const AbonementItem({
    super.key,
    required this.isHorizontal,
    required this.option,
    required this.isChosen,
  });

  @override
  Widget build(BuildContext context) {
    if (isHorizontal) {
      return _HorizontalAbonItem(option: option);
    } else {
      return _VerticalAbonItem(option: option, isChosen: isChosen);
    }
  }
}

class _VerticalAbonItem extends StatelessWidget {
  final AbonementOptionEntity option;
  final bool isChosen;
  const _VerticalAbonItem({required this.option, required this.isChosen});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 11),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: context.colors.containerDark,
        border: isChosen ? Border.all(color: context.colors.primaryColor, width: 1) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                option.planName,
                style: context.textStyle.sfProMedium.copyWith(
                  fontSize: 15,
                  height: 18 / 15,
                  color: context.colors.ebebf5Color.withAlpha(90),
                ),
              ),
              const Gap(4),
              if (option.label != null) _LabelWidget(labelText: option.label!),
            ],
          ),
          const Gap(10),
          Text(
            option.title,
            style: context.textStyle.sfProSemiBold.copyWith(
              fontSize: 24,
              height: 26 / 24,
              color: context.colors.whiteColor,
            ),
          ),
          const Gap(10),
          Text(
            option.subtitle,
            style: context.textStyle.sfProMedium.copyWith(
              fontSize: 14,
              height: 16 / 14,
              color: context.colors.grayDarkColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _HorizontalAbonItem extends StatelessWidget {
  final AbonementOptionEntity option;
  const _HorizontalAbonItem({required this.option});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 171,
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: context.colors.containerDark,
          ),
          child: Column(
            children: [
              Text(
                option.planName,
                style: context.textStyle.sfProMedium.copyWith(
                  fontSize: 16,
                  height: 20 / 16,
                  color: context.colors.whiteColor,
                ),
              ),
              const Gap(8),
              Text(
                option.title,
                style: context.textStyle.sfProSemiBold.copyWith(
                  fontSize: 20,
                  color: context.colors.whiteColor,
                ),
              ),
              const Gap(8),
              Text(
                option.subtitle,
                style: context.textStyle.sfProMedium.copyWith(
                  fontSize: 12,
                  height: 18 / 12,
                  color: context.colors.grayDarkColor,
                ),
              ),
            ],
          ),
        ),
        if (option.label != null)
          Positioned(right: 0, top: 0, child: _LabelWidget(labelText: option.label!)),
      ],
    );
  }
}

class _LabelWidget extends StatelessWidget {
  final String labelText;
  const _LabelWidget({required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.colors.primaryColor,
      ),
      child: Text(labelText, style: context.textStyle.sfProSemiBold.copyWith(fontSize: 10)),
    );
  }
}
