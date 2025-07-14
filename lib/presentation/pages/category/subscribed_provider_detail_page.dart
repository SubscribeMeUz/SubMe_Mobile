import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:gym_pro/assets/assets.dart';
import 'package:gym_pro/components/custom_app_bar.dart';
import 'package:gym_pro/config/enums/bloc_status.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:gym_pro/config/utils/frequent_methods.dart';
import 'package:gym_pro/domain/entity/my_subscription_entity.dart';
import 'package:gym_pro/presentation/bloc/abonements/abonement_bloc.dart';
import 'package:gym_pro/presentation/pages/category/widgets/about_widget.dart';
import 'package:gym_pro/presentation/pages/category/widgets/geo_location_widget.dart';
import 'package:gym_pro/presentation/pages/category/widgets/my_subscription_limit_widget.dart';

class SubscribedProviderDetailPageArgs {
  final int providerId;
  final MySubscriptionEntity mySubscriptionEntity;

  const SubscribedProviderDetailPageArgs({
    required this.providerId,
    required this.mySubscriptionEntity,
  });
}

class SubscribedProviderDetailPage extends StatefulWidget {
  final SubscribedProviderDetailPageArgs args;

  const SubscribedProviderDetailPage({super.key, required this.args});

  @override
  State<SubscribedProviderDetailPage> createState() => _SubscribedProviderDetailPageState();
}

class _SubscribedProviderDetailPageState extends State<SubscribedProviderDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<AbonementBloc>().add(GetProviderDetailEvent(providerId: widget.args.providerId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AbonementBloc, AbonementState>(
      listener: (context, state) {
        if (state.status == BlocStatus.error) {
          FrequentMethods.showSnackBar(context, state.errorMessage ?? '');
        }
      },
      child: Scaffold(
        backgroundColor: context.colors.modalDark,
        appBar: CustomAppBar(actions: [SvgPicture.asset(Assets.svgShare), const Gap(16)]),
        // bottomNavigationBar: BottomButtonBar(
        //   buttonText: 'Next',
        //   onTap: () {
        //     context.goNamed(RouteName.abonementsPage, extra: widget.args.providerId);
        //   },
        // ),
        body: BlocBuilder<AbonementBloc, AbonementState>(
          builder: (context, state) {
            if (state.status == BlocStatus.loading ||
                state.status == BlocStatus.error ||
                state.providerDetailEntity == null) {
              return Center(child: CircularProgressIndicator(color: context.colors.primaryColor));
            }
            return CustomScrollView(
              slivers: [
                const SliverGap(40),
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
                              widget.args.mySubscriptionEntity.logoUrl,
                            ),
                          ),
                        ),
                        child: const SizedBox(),
                      ),
                      const Gap(10),
                      Text(
                        widget.args.mySubscriptionEntity.name,
                        style: context.textStyle.sfProSemiBold.copyWith(
                          fontSize: 18,
                          color: context.colors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SliverGap(24),
                SliverToBoxAdapter(
                  child: MySubscriptionLimitWidget(entity: widget.args.mySubscriptionEntity),
                ),

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
