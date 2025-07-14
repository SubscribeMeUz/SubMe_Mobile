import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:gym_pro/assets/assets.dart';
import 'package:gym_pro/components/expandable_text.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:gym_pro/presentation/bloc/abonements/abonement_bloc.dart';

class AboutWidget extends StatelessWidget {
  const AboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbonementBloc, AbonementState>(
      builder: (context, state) {
        if (state.providerDetailEntity?.description == null ||
            state.providerDetailEntity?.description.isEmpty == true) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About',
                style: context.textStyle.sfProBold.copyWith(
                  fontSize: 20,
                  height: 25 / 20,
                  color: context.colors.whiteColor,
                ),
              ),
              const Gap(16),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: context.colors.cardDark,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: context.textStyle.sfProRegular.copyWith(
                        color: context.colors.ebebf5Color.withAlpha(60),
                      ),
                    ),
                    const Gap(4),
                    ExpandableText(text: state.providerDetailEntity!.description),

                    // Text(
                    //   state.providerDetailEntity!.description,
                    //   maxLines: state.aboutDescMaxline,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: context.textStyle.sfProRegular.copyWith(
                    //     color: context.colors.whiteColor,
                    //     fontSize: 14,
                    //     height: 22 / 14,
                    //   ),
                    // ),
                    // if (state.aboutDescMaxline == 3)
                    //   GestureDetector(
                    //     onTap: () {
                    //       context.read<AbonementBloc>().add(ReadMoreDescEvent());
                    //     },
                    //     child: Text(
                    //       'more',
                    //       style: context.textStyle.sfProRegular.copyWith(
                    //         color: context.colors.primaryColor,
                    //       ),
                    //     ),
                    //   ),
                  ],
                ),
              ),

              _item(Assets.svgTraining, '12 exclusive trainings'),
              _item(Assets.svgChat, 'Consultation with trainer'),
            ],
          ),
        );
      },
    );
  }

  Widget _item(String svgPath, String title) {
    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            children: [
              SvgPicture.asset(
                svgPath,
                colorFilter: ColorFilter.mode(context.colors.whiteColor, BlendMode.srcIn),
              ),
              const Gap(4),
              Text(
                title,
                style: context.textStyle.sfProLight.copyWith(color: context.colors.whiteColor),
              ),
            ],
          ),
        );
      },
    );
  }
}
