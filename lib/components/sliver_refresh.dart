import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_pro/config/style/app_colors.dart';

class CustomSliverPullRefresh extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Color? color;

  const CustomSliverPullRefresh({required this.onRefresh, super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverRefreshControl(
      onRefresh: onRefresh,
      builder: (
        context,
        refreshState,
        pulledExtent,
        refreshTriggerPullDistance,
        refreshIndicatorExtent,
      ) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: refreshIndicatorExtent,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Center(
              child: CupertinoActivityIndicator(color: color ?? context.colors.primaryColor),
            ),
          ),
        );
      },
    );
  }
}
