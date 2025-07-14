import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_pro/assets/assets.dart';
import 'package:gym_pro/components/custom_button.dart';
import 'package:gym_pro/components/favourited_item_widget.dart';
import 'package:gym_pro/components/horizontal_list_widget.dart';
import 'package:gym_pro/components/sliver_refresh.dart';
import 'package:gym_pro/config/enums/bloc_status.dart';
import 'package:gym_pro/config/localisation/app_localisation.dart';
import 'package:gym_pro/config/localisation/localisation_keys.dart';
import 'package:gym_pro/config/router/route_name.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:gym_pro/domain/entity/favourite_entity.dart';
import 'package:gym_pro/presentation/bloc/subscriptions/subscription_bloc.dart';
import 'package:gym_pro/presentation/pages/category/subscribed_provider_detail_page.dart';
import 'package:gym_pro/presentation/pages/home/widgets/ad_widget.dart';
import 'package:gym_pro/presentation/pages/home/widgets/my_subscription_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SubscriptionBloc>().add(GetMySubscriptionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 16, bottom: 8),
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              title: Text(
                'SubMe',
                style: context.textStyle.sfProBold.copyWith(
                  fontSize: 28,
                  color: context.colors.whiteColor,
                ),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  context.goNamed(RouteName.providersRoute);
                },
                child: SvgPicture.asset(Assets.svgAddIcon, height: 24, width: 24),
              ),
              const Gap(16),
              SvgPicture.asset(Assets.svgNotificationIcon, height: 24, width: 24),
              const Gap(12),
            ],
          ),
          CustomSliverPullRefresh(
            onRefresh: () async {
              context.read<SubscriptionBloc>().add(GetMySubscriptionsEvent());
            },
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            sliver: SliverToBoxAdapter(
              child: CupertinoSearchTextField(
                controller: _searchController,
                placeholder: context.tr(LocalisationKeys.search),
                autocorrect: false,
                cursorColor: context.colors.primaryColor,
                backgroundColor: context.colors.cardDark,
                style: context.textStyle.sfProMedium.copyWith(
                  fontSize: 17,
                  color: context.colors.whiteColor,
                ),
              ),
            ),
          ),
          const SliverGap(15),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: AdWidget(
                title: 'First Month — Free! 🎉',
                subtitle:
                    'Start your fitness journey today! Enjoy your first month as a gift with SubMe.',
                imagePath: Assets.coverLogo,
                onTap: () {},
              ),
            ),
          ),
          const SliverGap(12),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: BlocBuilder<SubscriptionBloc, SubscriptionState>(
                builder: (context, state) {
                  if (state.status == BlocStatus.loading) {
                    return Center(
                      child: CircularProgressIndicator(color: context.colors.primaryColor),
                    );
                  }
                  return MySubscriptionWidget(
                    mySubscriptions: state.myAbonements,
                    onTapIndex: (index) {
                      context.goNamed(
                        RouteName.subscribedDetailRoute,
                        extra: SubscribedProviderDetailPageArgs(
                          providerId: state.myAbonements[index].providerId,
                          mySubscriptionEntity: state.myAbonements[index],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          const SliverGap(12),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: BlocBuilder<SubscriptionBloc, SubscriptionState>(
                builder: (context, state) {
                  if (state.myAbonements.isEmpty) {
                    return SizedBox.shrink();
                  }
                  return CustomButton(
                    onTap: () {
                      context.goNamed(RouteName.mySubscriptionsRoute);
                    },
                    buttonText: context.tr(LocalisationKeys.my_subscriptions),
                    buttonType: ButtonType.secondary,
                  );
                },
              ),
            ),
          ),
          const SliverGap(12),

          SliverToBoxAdapter(
            child: HorizontalListWidget(
              title: context.tr(LocalisationKeys.favorited_trainer),
              listChild: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 7,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return FavouritedItemWidget(
                    entity: FavouriteEntity(
                      imagePath:
                          'https://landmarksarchitects.com/wp-content/uploads/2024/04/Functionality-and-Space-Planning-03.04.2024.jpg',
                      title: 'Abdulaziz K.',
                      subtitle: 'Experienced trainer',
                    ),
                    onTap: () {},
                  );
                },
                separatorBuilder: (context, index) => const Gap(12),
              ),
            ),
          ),
          const SliverGap(150),
        ],
      ),
    );
  }
}
