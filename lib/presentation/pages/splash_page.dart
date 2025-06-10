import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_pro/config/router/route_name.dart';
import 'package:gym_pro/config/style/app_text_style.dart';

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

    if (mounted) {
      context.goNamed(RouteName.welcomeRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Center(
        child: Text('Gym Pro', style: context.textStyle.sfProBold.copyWith(fontSize: 22)),
      ),
    );
  }
}
