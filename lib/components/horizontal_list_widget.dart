import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';

class HorizontalListWidget extends StatelessWidget {
  final String title;
  final Widget listChild;

  const HorizontalListWidget({super.key, required this.title, required this.listChild});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            title,
            style: context.textStyle.sfProSemiBold.copyWith(
              fontSize: 20,
              height: 25 / 20,
              color: context.colors.whiteColor,
            ),
          ),
        ),
        const Gap(16),
        SizedBox(height: 142, child: listChild),
      ],
    );
  }
}
