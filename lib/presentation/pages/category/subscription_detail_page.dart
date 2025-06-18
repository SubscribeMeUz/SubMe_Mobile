import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gym_pro/assets/assets.dart';
import 'package:gym_pro/components/bottom_button_bar.dart';
import 'package:gym_pro/components/custom_app_bar.dart';
import 'package:gym_pro/components/favourited_item_widget.dart';
import 'package:gym_pro/components/horizontal_list_widget.dart';
import 'package:gym_pro/config/localisation/app_localisation.dart';
import 'package:gym_pro/config/localisation/localisation_keys.dart';
import 'package:gym_pro/config/router/route_name.dart';
import 'package:gym_pro/domain/entity/favourite_entity.dart';
import 'package:gym_pro/presentation/pages/category/widgets/about_widget.dart';
import 'package:gym_pro/presentation/pages/category/widgets/carousel_widget.dart';
import 'package:gym_pro/presentation/pages/category/widgets/geo_location_widget.dart';
import 'package:gym_pro/presentation/pages/category/widgets/gym_title_widget.dart';
import 'package:gym_pro/presentation/pages/category/widgets/location_widget.dart';

class SubscriptionDetailPage extends StatefulWidget {
  const SubscriptionDetailPage({super.key});

  @override
  State<SubscriptionDetailPage> createState() => _SubscriptionDetailPageState();
}

class _SubscriptionDetailPageState extends State<SubscriptionDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(actions: [SvgPicture.asset(Assets.svgShare), const Gap(16)]),
      bottomNavigationBar: BottomButtonBar(
        buttonText: 'Next',
        onTap: () {
          context.goNamed(RouteName.abonementsPage);
        },
      ),
      body: CustomScrollView(
        slivers: [
          const SliverGap(16),
          SliverToBoxAdapter(child: CarouselWidget()),
          const SliverGap(24),
          SliverToBoxAdapter(child: GymTitleWidget()),
          const SliverGap(16),
          SliverToBoxAdapter(child: LocationWidget()),
          const SliverGap(16),
          SliverToBoxAdapter(child: AboutWidget()),
          const SliverGap(16),
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
          const SliverGap(24),
          SliverToBoxAdapter(
            child: GeoLocationWidget(latLng: LatLng(41.313395, 69.273615), providerId: 1),
          ),
        ],
      ),
    );
  }
}
