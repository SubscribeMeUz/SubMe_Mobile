import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_pro/assets/assets.dart';
import 'package:gym_pro/components/custom_app_bar.dart';
import 'package:gym_pro/components/success_page.dart';
import 'package:gym_pro/config/enums/bloc_status.dart';
import 'package:gym_pro/config/router/route_name.dart';
import 'package:gym_pro/config/utils/frequent_methods.dart';
import 'package:gym_pro/presentation/bloc/auth/auth_bloc.dart';
import 'package:gym_pro/presentation/pages/confirmation_ui.dart';

class ConfirmNumberPage extends StatefulWidget {
  final String phoneNumber;
  const ConfirmNumberPage({super.key, required this.phoneNumber});

  @override
  State<ConfirmNumberPage> createState() => _ConfirmNumberPageState();
}

class _ConfirmNumberPageState extends State<ConfirmNumberPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == BlocStatus.failure) {
          FrequentMethods.showSnackBar(context, state.errorMessage ?? '');
        } else if (state.status == BlocStatus.success) {
          context.goNamed(
            RouteName.successRoute,
            extra: SuccessPageArgs(
              iconPath: Assets.svgLoginSuccess,
              title: 'Login Successful',
              subtitle: 'Welcome back! Manage all your gym subscriptions in one place with GymPro.',
              onSubmit: () {},
            ),
          );
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(),
        body: ConfirmationUi(
          phoneNumber: FrequentMethods.phoneFormatter(widget.phoneNumber),
          onSubmit: (otpCode) {
            context.read<AuthBloc>().add(
              ConfirmNumberEvent(phone: widget.phoneNumber, code: otpCode),
            );
          },
          onResendCode: () {},
        ),
      ),
    );
  }
}
