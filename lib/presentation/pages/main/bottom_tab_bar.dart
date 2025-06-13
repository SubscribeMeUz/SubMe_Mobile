import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gym_pro/assets/assets.dart';
import 'package:gym_pro/config/localisation/app_localisation.dart';
import 'package:gym_pro/config/localisation/localisation_keys.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';

enum Tabs {
  main(tabIndex: 0),
  assistant(tabIndex: 1),
  // qrScan(tabIndex: 2),
  statistics(tabIndex: 2),
  profile(tabIndex: 3);

  final int tabIndex;

  const Tabs({required this.tabIndex});
}

class CustomBottomTabBar extends StatelessWidget {
  final int? currentIndex;
  final Function(int) onTap;

  const CustomBottomTabBar({super.key, this.currentIndex = 0, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(
        context,
      ).copyWith(splashColor: Colors.transparent, highlightColor: Colors.transparent),
      child: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(offset: const Offset(0, -0.33), blurRadius: 50, color: Colors.white12),
          ],
        ),
        child: BottomAppBar(
          height: 70,
          shape: const CircularNotchedRectangle(),
          color: context.colors.backgroundColor,
          padding: EdgeInsets.zero,
          child: BottomNavigationBar(
            selectedFontSize: 10,
            unselectedFontSize: 10,
            selectedItemColor: context.colors.primaryColor,
            unselectedItemColor: context.colors.grayDarkColor,
            backgroundColor: context.colors.blackColor.withAlpha(75),
            onTap: onTap,
            currentIndex: currentIndex!,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: context.textStyle.sfProMedium.copyWith(fontSize: 13),
            unselectedLabelStyle: context.textStyle.sfProMedium.copyWith(fontSize: 13),
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                label: context.tr(LocalisationKeys.home_tab),
                icon: svgIcon(context, Assets.svgHomeIcon, false),
                activeIcon: svgIcon(context, Assets.svgHomeIcon, true),
              ),
              BottomNavigationBarItem(
                label: context.tr(LocalisationKeys.assistant_tab),
                icon: svgIcon(context, Assets.svgAiAssistant, false),
                activeIcon: svgIcon(context, Assets.svgAiAssistant, true),
              ),

              BottomNavigationBarItem(
                label: context.tr(LocalisationKeys.statistics_tab),
                icon: svgIcon(context, Assets.svgStatisticsIcon, false),
                activeIcon: svgIcon(context, Assets.svgStatisticsIcon, true),
              ),
              BottomNavigationBarItem(
                label: context.tr(LocalisationKeys.profile_tab),
                icon: svgIcon(context, Assets.svgProfileIcon, false),
                activeIcon: svgIcon(context, Assets.svgProfileIcon, true),
              ),
            ],
          ),
        ),
      ),
    );
  }

  svgIcon(BuildContext context, String assetName, bool isSelected) {
    return SvgPicture.asset(
      assetName,
      width: 28,
      height: 28,
      colorFilter: ColorFilter.mode(
        isSelected ? context.colors.primaryColor : context.colors.grayDarkColor,
        BlendMode.srcIn,
      ),
    );
  }
}
