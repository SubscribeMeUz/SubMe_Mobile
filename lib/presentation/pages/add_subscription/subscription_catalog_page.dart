import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_pro/config/localisation/app_localisation.dart';
import 'package:gym_pro/config/localisation/localisation_keys.dart';
import 'package:gym_pro/config/router/route_name.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:gym_pro/domain/entity/subcription_entity.dart';
import 'package:gym_pro/presentation/pages/add_subscription/widgets/subscription_circle_widget.dart';

class SubscriptionCatalogPage extends StatefulWidget {
  const SubscriptionCatalogPage({super.key});

  @override
  State<SubscriptionCatalogPage> createState() => _SubscriptionCatalogPageState();
}

class _SubscriptionCatalogPageState extends State<SubscriptionCatalogPage> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(
              context.tr(LocalisationKeys.select_active_subscription),

              style: context.textStyle.sfProBold.copyWith(
                fontSize: 34,
                color: context.colors.whiteColor,
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  context.goNamed(RouteName.homeRoute);
                },
                behavior: HitTestBehavior.opaque,
                child: Text(
                  context.tr(LocalisationKeys.skip),
                  style: context.textStyle.sfProRegular.copyWith(
                    fontSize: 17,
                    color: context.colors.primaryColor,
                  ),
                ),
              ),
              const Gap(12),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8.0),
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

          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 24.0,
                crossAxisSpacing: 25.0,
                mainAxisExtent: 136,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return SubscriptionCircleWidget(
                  entity: SubscriptionEntity(
                    discount: 20,
                    logoUrl:
                        'https://landmarksarchitects.com/wp-content/uploads/2024/04/Functionality-and-Space-Planning-03.04.2024.jpg',
                    latLng: null,
                    necessaryTools: null,
                    id: 0,
                    name: 'Powerhouse',
                    images: [
                      'https://landmarksarchitects.com/wp-content/uploads/2024/04/Functionality-and-Space-Planning-03.04.2024.jpg',
                      'https://landmarksarchitects.com/wp-content/uploads/2024/04/Functionality-and-Space-Planning-03.04.2024.jpg',
                    ],
                    description: '',
                    address: null,
                  ),
                  onChoose: (id) {
                    //TODO choose subscriptions
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
