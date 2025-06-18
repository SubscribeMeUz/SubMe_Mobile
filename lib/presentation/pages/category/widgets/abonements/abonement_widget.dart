import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:gym_pro/domain/entity/provider_abonements_entity.dart';
import 'package:gym_pro/presentation/pages/category/widgets/abonements/abonement_item.dart';

enum AbonType { first, sec }

class AbonementWidget extends StatelessWidget {
  final bool isHorizontal;
  final List<AbonementBlock> blocks;
  final int chosenIndex;
  const AbonementWidget({
    super.key,
    required this.blocks,
    required this.isHorizontal,
    required this.chosenIndex,
  });

  @override
  Widget build(BuildContext context) {
    if (isHorizontal) {
      return _HorizontalList(blocks: blocks);
    } else {
      return _VerticalList(blocks: blocks, chosenIndex: chosenIndex);
    }
  }
}

class _VerticalList extends StatelessWidget {
  final List<AbonementBlock> blocks;
  final int chosenIndex;
  final bool isPopular;
  const _VerticalList({required this.blocks, this.isPopular = false, required this.chosenIndex});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: blocks[0].options.length,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const Gap(10),
      itemBuilder: (context, index) {
        final item = blocks[0].options[index];
        return AbonementItem(isChosen: chosenIndex == index, isHorizontal: false, option: item);
      },
    );
  }
}

class _HorizontalList extends StatelessWidget {
  const _HorizontalList({required this.blocks});

  final List<AbonementBlock> blocks;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: blocks.length,
      separatorBuilder: (context, index) => Gap(16),
      itemBuilder: (context, index) {
        final item = blocks[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.title != null) ...[
              Text(
                item.title!,
                style: context.textStyle.sfProSemiBold.copyWith(
                  color: context.colors.ebebf5Color.withAlpha(60),
                  fontSize: 15,
                  height: 20 / 15,
                ),
              ),
              const Gap(15),
            ],
            SizedBox(
              height: 112,
              child: ListView.separated(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: item.options.length,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => const Gap(10),
                itemBuilder: (context, index) {
                  return AbonementItem(
                    isChosen: false,
                    isHorizontal: true,
                    option: item.options[index],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
