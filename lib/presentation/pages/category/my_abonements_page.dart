import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_pro/components/custom_app_bar.dart';
import 'package:gym_pro/config/enums/bloc_status.dart';
import 'package:gym_pro/config/localisation/app_localisation.dart';
import 'package:gym_pro/config/localisation/localisation_keys.dart';
import 'package:gym_pro/config/router/route_name.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/presentation/bloc/subscriptions/subscription_bloc.dart';
import 'package:gym_pro/presentation/pages/home/widgets/my_subscription_widget.dart';

class MySubscriptionsPage extends StatefulWidget {
  const MySubscriptionsPage({super.key});

  @override
  State<MySubscriptionsPage> createState() => _ProviderListPageState();
}

class _ProviderListPageState extends State<MySubscriptionsPage> {
  @override
  void initState() {
    super.initState();
    context.read<SubscriptionBloc>().add(GetMySubscriptionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: context.colors.containerDark,
        titleText: context.tr(LocalisationKeys.my_subscriptions),
      ),
      body: BlocBuilder<SubscriptionBloc, SubscriptionState>(
        builder: (context, state) {
          if (state.status == BlocStatus.success) {
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: context.colors.containerDark,
                ),
                child: MySubscriptionWidget(
                  mySubscriptions: state.myAbonements,
                  onTapIndex: (index) {
                    context.pushNamed(
                      RouteName.subscriptionDetailPage,
                      extra: state.myAbonements[index].providerId,
                    );
                  },
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator(color: context.colors.primaryColor));
        },
      ),
    );
  }
}
