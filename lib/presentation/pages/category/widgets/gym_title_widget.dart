import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:gym_pro/assets/assets.dart';
import 'package:gym_pro/components/dot_widget.dart';
import 'package:gym_pro/config/enums/bloc_status.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:gym_pro/presentation/bloc/abonements/abonement_bloc.dart';

class GymTitleWidget extends StatelessWidget {
  const GymTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbonementBloc, AbonementState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.providerDetailEntity == null || state.status == BlocStatus.loading) {
          return const SizedBox.shrink();
        }
        final detail = state.providerDetailEntity!;
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
                          image: CachedNetworkImageProvider(detail.logoUrl ?? ''),
                        ),
                      ),
                      child: const SizedBox(),
                    ),
                    Text(
                      detail.name,
                      style: context.textStyle.sfProSemiBold.copyWith(
                        fontSize: 20,
                        height: 25 / 20,
                        color: context.colors.whiteColor,
                      ),
                    ),
                  ],
                ),
                if (detail.discount != null && detail.discount != 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: context.colors.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '-${detail.discount}%',
                      style: context.textStyle.sfProRegular.copyWith(
                        color: context.colors.blackColor,
                      ),
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
      },
    );
  }
}
