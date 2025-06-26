import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_pro/assets/assets.dart';
import 'package:gym_pro/config/cache/cache_keys.dart';
import 'package:gym_pro/config/cache/local_storage.dart';
import 'package:gym_pro/config/router/route_name.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  @override
  void initState() {
    nextPage();
    super.initState();
  }

  Future<void> nextPage() async {
    await Future.delayed(Duration(seconds: 3));
    final isTokenAvailable = LocalStorage.getString(CacheKeys.accessToken, defValue: '').isNotEmpty;
    if (mounted) {
      if (isTokenAvailable) {
        context.goNamed(RouteName.homeRoute);
      } else {
        context.goNamed(RouteName.welcomeRoute);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Center(child: Image.asset(Assets.pngLogo, width: 270, height: 270)),
    );
  }
}
