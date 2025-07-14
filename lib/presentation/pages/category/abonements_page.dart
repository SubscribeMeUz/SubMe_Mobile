import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_pro/assets/assets.dart';
import 'package:gym_pro/components/bottom_button_bar.dart';
import 'package:gym_pro/components/custom_app_bar.dart';
import 'package:gym_pro/components/success_page.dart';
import 'package:gym_pro/components/tab_widget.dart';
import 'package:gym_pro/config/enums/bloc_status.dart';
import 'package:gym_pro/config/localisation/app_localisation.dart';
import 'package:gym_pro/config/localisation/localisation_keys.dart';
import 'package:gym_pro/config/router/route_name.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:gym_pro/config/utils/frequent_methods.dart';
import 'package:gym_pro/presentation/bloc/abonements/abonement_bloc.dart';
import 'package:gym_pro/presentation/bloc/subscriptions/subscription_bloc.dart';
import 'package:gym_pro/presentation/pages/category/widgets/abonements/abonement_widget.dart';

class AbonementsPage extends StatefulWidget {
  final int providerId;
  const AbonementsPage({super.key, required this.providerId});

  @override
  State<AbonementsPage> createState() => _AbonementsPageState();
}

class _AbonementsPageState extends State<AbonementsPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    context.read<AbonementBloc>().add(GetProviderAbonementsEvent(providerId: widget.providerId));
    _tabController = TabController(length: 0, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SubscriptionBloc, SubscriptionState>(
      listener: (context, state) {
        if (state.status == BlocStatus.success) {
          context.goNamed(
            RouteName.successRoute,
            extra: SuccessPageArgs(
              iconPath: Assets.svgSuccessTick,
              title: context.tr(LocalisationKeys.buy_success),
              subtitle: context.tr(LocalisationKeys.buy_desc_success),
              buttonText: context.tr(LocalisationKeys.goToHome),
              onSubmit: (successContext) {
                successContext.goNamed(RouteName.homeRoute);
              },
            ),
          );
        } else if (state.status == BlocStatus.error) {
          FrequentMethods.showSnackBar(context, state.errorMessage ?? '');
        }
      },
      child: BlocListener<AbonementBloc, AbonementState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == BlocStatus.success) {
            _tabController = TabController(
              length: state.providerTariffList?.tabEntity?.length ?? 0,
              vsync: this,
            );
            setState(() {});
          } else if (state.status == BlocStatus.error) {
            FrequentMethods.showSnackBar(context, state.errorMessage ?? '');
          }
        },
        child: Scaffold(
          backgroundColor: context.colors.modalDark,
          appBar: CustomAppBar(),
          bottomNavigationBar: BlocBuilder<AbonementBloc, AbonementState>(
            buildWhen: (previous, current) => previous.chosenOptionId != current.chosenOptionId,
            builder: (context, state) {
              return BottomButtonBar(
                backgroundColor: context.colors.modalDark,
                buttonText: 'Buy subscription',
                onTap: () {
                  if (state.chosenOptionId == null) {
                    return;
                  }
                  context.read<SubscriptionBloc>().add(
                    PurchaseSubscriptionEvent(abonementId: state.chosenOptionId!),
                  );
                },
              );
            },
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<AbonementBloc, AbonementState>(
              builder: (context, state) {
                if (state.providerTariffList != null) {
                  final data = state.providerTariffList!;
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Container(
                              height: 75,
                              width: 75,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                    data.logo,
                                    maxHeight: 80,
                                    maxWidth: 80,
                                  ),
                                ),
                              ),
                            ),
                            const Gap(10),
                            Text(
                              data.title,
                              style: context.textStyle.sfProSemiBold.copyWith(
                                color: context.colors.whiteColor,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SliverGap(24),
                      if (data.tabEntity != null)
                        SliverToBoxAdapter(
                          child: TabWidget(
                            tabController: _tabController,
                            onTap: (index) {
                              context.read<AbonementBloc>().add(
                                ChangeTabIndexEvent(tabIndex: index),
                              );
                            },
                            tabs: List.generate(
                              data.tabEntity!.length,
                              (i) => Tab(text: data.tabEntity![i].title),
                            ),
                          ),
                        ),
                      const SliverGap(24),
                      SliverToBoxAdapter(
                        child: AbonementWidget(
                          onChoose: (optionId) {
                            context.read<AbonementBloc>().add(
                              ChooseTariffOptionEvent(optionId: optionId),
                            );
                          },
                          isHorizontal: data.isHorizontal,
                          chosenId: state.chosenOptionId,
                          blocks:
                              data.abonements[(data.tabEntity?[state.tabIndex].value) ??
                                  'default'] ??
                              [],
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
