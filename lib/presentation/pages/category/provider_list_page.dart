import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_pro/components/custom_app_bar.dart';
import 'package:gym_pro/config/enums/bloc_status.dart';
import 'package:gym_pro/config/router/route_name.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:gym_pro/presentation/bloc/subscriptions/subscription_bloc.dart';
import 'package:gym_pro/presentation/pages/category/widgets/provider/provider_widget.dart';

class ProviderListPage extends StatefulWidget {
  const ProviderListPage({super.key});

  @override
  State<ProviderListPage> createState() => _ProviderListPageState();
}

class _ProviderListPageState extends State<ProviderListPage> {
  @override
  void initState() {
    super.initState();
    context.read<SubscriptionBloc>().add(GetSubscriptionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: context.colors.containerDark,
        titleText: 'Add Subscriptions',
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16),
                      child: Text(
                        'Subscriptions',
                        style: context.textStyle.sfProSemiBold.copyWith(
                          color: context.colors.whiteColor,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.subscriptions.length,
                      itemBuilder: (context, i) {
                        final provider = state.subscriptions[i];
                        return ProviderWidget(
                          providerEntity: provider,
                          onTap: () {
                            context.goNamed(RouteName.subscriptionDetailPage, extra: provider.id);
                          },
                        );
                      },
                    ),
                  ],
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
