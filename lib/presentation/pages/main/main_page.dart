import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_pro/assets/assets.dart';
import 'package:gym_pro/config/router/route_name.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/utils/frequent_methods.dart';
import 'package:gym_pro/presentation/pages/main/bottom_tab_bar.dart';

class MainPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final GoRouterState state;
  const MainPage({super.key, required this.navigationShell, required this.state});

  static const tabRootRoutes = ['/home', '/assistant', '/statistics', '/profile'];

  void _goBranch(context, int index) {
    if (index == 0 || index == 3) {
      navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
    } else if (index == 1) {
      FrequentMethods.showAlertDialog(
        context,
        'AI feature is coming soon',
        'We’re working on something intelligent. Stay tuned for powerful new capabilities.',
      );
    } else if (index == 2) {
      FrequentMethods.showAlertDialog(
        context,
        'Statistics will be available soon',
        'Get insights based on your activity. This feature is under development.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = state.uri.path;
    var isShowBottomNavBar = tabRootRoutes.contains(location);
    return Scaffold(
      body: navigationShell,
      extendBodyBehindAppBar: true,
      floatingActionButton:
          isShowBottomNavBar
              ? Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: FloatingActionButton(
                    onPressed: () {
                      context.pushNamed(RouteName.qrScanRoute);
                    },
                    shape: CircleBorder(),
                    backgroundColor: context.colors.primaryColor,
                    child: SvgPicture.asset(Assets.svgQrScanIcon, height: 28, width: 28),
                  ),
                ),
              )
              : null,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar:
          isShowBottomNavBar
              ? CustomBottomTabBar(
                onTap: (index) {
                  _goBranch(context, index);
                },
                currentIndex: navigationShell.currentIndex,
              )
              : null,
    );
  }
}
