import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_pro/assets/assets.dart';
import 'package:gym_pro/components/bottom_button_bar.dart';
import 'package:gym_pro/components/custom_app_bar.dart';
import 'package:gym_pro/config/enums/bloc_status.dart';
import 'package:gym_pro/config/router/route_name.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/utils/frequent_methods.dart';
import 'package:gym_pro/presentation/bloc/abonements/abonement_bloc.dart';
import 'package:gym_pro/presentation/pages/category/widgets/about_widget.dart';
import 'package:gym_pro/presentation/pages/category/widgets/carousel_widget.dart';
import 'package:gym_pro/presentation/pages/category/widgets/geo_location_widget.dart';
import 'package:gym_pro/presentation/pages/category/widgets/gym_title_widget.dart';
import 'package:gym_pro/presentation/pages/category/widgets/location_widget.dart';

class SubscriptionDetailPage extends StatefulWidget {
  final int providerId;
  const SubscriptionDetailPage({super.key, required this.providerId});

  @override
  State<SubscriptionDetailPage> createState() => _SubscriptionDetailPageState();
}

class _SubscriptionDetailPageState extends State<SubscriptionDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<AbonementBloc>().add(GetProviderDetailEvent(providerId: widget.providerId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AbonementBloc, AbonementState>(
      listener: (context, state) {
        if (state.status == BlocStatus.failure) {
          FrequentMethods.showSnackBar(context, state.errorMessage ?? '');
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(actions: [SvgPicture.asset(Assets.svgShare), const Gap(16)]),
        bottomNavigationBar: BottomButtonBar(
          buttonText: 'Next',
          onTap: () {
            context.goNamed(RouteName.abonementsPage, extra: widget.providerId);
          },
        ),
        body: BlocBuilder<AbonementBloc, AbonementState>(
          builder: (context, state) {
            if (state.status == BlocStatus.loading ||
                state.status == BlocStatus.failure ||
                state.providerDetailEntity == null) {
              return Center(child: CircularProgressIndicator(color: context.colors.primaryColor));
            }
            return CustomScrollView(
              slivers: [
                const SliverGap(16),
                SliverToBoxAdapter(child: CarouselWidget()),
                const SliverGap(24),
                SliverToBoxAdapter(child: GymTitleWidget()),
                const SliverGap(16),
                SliverToBoxAdapter(child: LocationWidget()),
                const SliverGap(16),
                SliverToBoxAdapter(child: AboutWidget()),

                // const SliverGap(16),
                // SliverToBoxAdapter(
                //   child: HorizontalListWidget(
                //     title: context.tr(LocalisationKeys.favorited_trainer),
                //     listChild: ListView.separated(
                //       scrollDirection: Axis.horizontal,
                //       padding: const EdgeInsets.symmetric(horizontal: 16),
                //       itemCount: 7,
                //       shrinkWrap: true,
                //       physics: const BouncingScrollPhysics(),
                //       itemBuilder: (context, index) {
                //         return FavouritedItemWidget(
                //           entity: FavouriteEntity(
                //             imagePath:
                //                 'https://landmarksarchitects.com/wp-content/uploads/2024/04/Functionality-and-Space-Planning-03.04.2024.jpg',
                //             title: 'Abdulaziz K.',
                //             subtitle: 'Experienced trainer',
                //           ),
                //           onTap: () {},
                //         );
                //       },
                //       separatorBuilder: (context, index) => const Gap(12),
                //     ),
                //   ),
                // ),
                if (state.providerDetailEntity!.latLng != null) ...[
                  const SliverGap(24),
                  SliverToBoxAdapter(
                    child: GeoLocationWidget(
                      latLng: state.providerDetailEntity!.latLng!,
                      providerId: state.providerDetailEntity!.id,
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
