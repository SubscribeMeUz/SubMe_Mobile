import 'package:flutter/material.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';

class TabWidget extends StatelessWidget {
  final TabController tabController;
  final List<Tab> tabs;

  const TabWidget({required this.tabController, required this.tabs, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: context.colors.blackColor,
        borderRadius: BorderRadius.circular(13),
      ),
      child: TabBar(
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: context.colors.whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        splashBorderRadius: BorderRadius.circular(10),
        labelColor: context.colors.blackColor,
        unselectedLabelColor: context.colors.grayDarkColor,
        labelStyle: context.textStyle.sfProMedium.copyWith(fontSize: 14, height: 18 / 14),
        unselectedLabelStyle: context.textStyle.sfProMedium.copyWith(fontSize: 14, height: 18 / 14),
        tabs: tabs,
      ),
    );
  }
}
