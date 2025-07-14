import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:gym_pro/assets/assets.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:gym_pro/presentation/bloc/abonements/abonement_bloc.dart';

class LocationWidget extends StatelessWidget {
  final bool needsPadding;
  final Color? textColor;
  const LocationWidget({super.key, this.needsPadding = true, this.textColor});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbonementBloc, AbonementState>(
      builder: (context, state) {
        if (state.providerDetailEntity == null || state.providerDetailEntity?.address == null) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: needsPadding ? const EdgeInsets.symmetric(horizontal: 16.0) : EdgeInsets.zero,
          child: Column(
            children: [
              _item(
                context: context,
                svgPath: Assets.svgLocation,
                title: state.providerDetailEntity!.address!,
                textColor: textColor,
              ),
              // const Gap(8),
              // _item(context: context, svgPath: Assets.svgNavigation, title: '6.4 km from you'),
            ],
          ),
        );
      },
    );
  }

  Widget _item({
    required BuildContext context,
    required String svgPath,
    required String title,
    Color? textColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
        Flexible(
          child: Text(
            title,
            style: context.textStyle.sfProLight.copyWith(
              color: textColor ?? context.colors.grayDarkColor,
            ),
          ),
        ),
      ],
    );
  }
}
