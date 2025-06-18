import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:gym_pro/assets/assets.dart';
import 'package:gym_pro/components/custom_button.dart';
import 'package:gym_pro/components/favourited_item_widget.dart';
import 'package:gym_pro/components/horizontal_list_widget.dart';
import 'package:gym_pro/config/localisation/app_localisation.dart';
import 'package:gym_pro/config/localisation/localisation_keys.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:gym_pro/domain/entity/favourite_entity.dart';
import 'package:gym_pro/domain/entity/my_subscription_entity.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
                'SubscribeMe',
                style: context.textStyle.sfProBold.copyWith(
                  fontSize: 28,
                  color: context.colors.whiteColor,
                ),
              ),
            ),
            actions: [
              SvgPicture.asset(Assets.svgAddIcon, height: 24, width: 24),
              const Gap(16),
              SvgPicture.asset(Assets.svgNotificationIcon, height: 24, width: 24),
              const Gap(12),
            ],
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
                    'Start your fitness journey today! Enjoy your first month as a gift with GymPro.',
                imagePath: Assets.pngLogo,
                onTap: () {},
              ),
            ),
          ),
          const SliverGap(12),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: MySubscriptionWidget(
                mySubscriptions: [
                  MySubscriptionEntity(
                    id: 0,
                    providerId: 1,
                    name: 'Powerhouse Gym',
                    logoUrl:
                        'https://landmarksarchitects.com/wp-content/uploads/2024/04/Functionality-and-Space-Planning-03.04.2024.jpg',
                    isPopular: false,
                    period: '6 month',
                    finishDate: DateTime(2025, 10, 15),
                    leftDays: 90,
                  ),
                ],
              ),
            ),
          ),
          const SliverGap(12),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: CustomButton(
                onTap: () {},
                buttonText: context.tr(LocalisationKeys.other_subscriptions),
                buttonType: ButtonType.secondary,
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
