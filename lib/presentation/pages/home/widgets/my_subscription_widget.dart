import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_pro/components/custom_button.dart';
import 'package:gym_pro/config/localisation/app_localisation.dart';
import 'package:gym_pro/config/localisation/localisation_keys.dart';
import 'package:gym_pro/config/router/route_name.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:gym_pro/domain/entity/my_subscription_entity.dart';
import 'package:intl/intl.dart';

class MySubscriptionWidget extends StatefulWidget {
  final List<MySubscriptionEntity> mySubscriptions;
  final void Function(int) onTapIndex;
  const MySubscriptionWidget({super.key, required this.mySubscriptions, required this.onTapIndex});

  @override
  State<MySubscriptionWidget> createState() => _MySubscriptionWidgetState();
}

class _MySubscriptionWidgetState extends State<MySubscriptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: context.colors.cardDark,
      ),
      child:
          widget.mySubscriptions.isEmpty
              ? CustomButton(
                onTap: () {
                  context.goNamed(RouteName.providersRoute);
                },
                buttonText: context.tr(LocalisationKeys.add_subscription),
              )
              : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr(LocalisationKeys.active_subscriptions),
                    style: context.textStyle.sfProSemiBold.copyWith(
                      fontSize: 20,
                      color: context.colors.whiteColor,
                    ),
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: widget.mySubscriptions.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          widget.onTapIndex(index);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: _MySubscriptionItemWidget(entity: widget.mySubscriptions[index]),
                      );
                    },
                  ),
                ],
              ),
    );
  }
}

class _MySubscriptionItemWidget extends StatelessWidget {
  final MySubscriptionEntity entity;

  const _MySubscriptionItemWidget({required this.entity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(entity.logoUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(12),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entity.name,
                    style: context.textStyle.sfProMedium.copyWith(
                      fontSize: 17,
                      color: context.colors.whiteColor,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    '${entity.period} days',
                    style: context.textStyle.sfProMedium.copyWith(
                      fontSize: 14,
                      color: context.colors.ebebf5Color.withAlpha(80),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${entity.leftCount} / ${entity.totalCount}',
                style: context.textStyle.sfProMedium.copyWith(
                  fontSize: 17,
                  color: context.colors.whiteColor,
                ),
              ),

              const Gap(2),
              Text(
                DateFormat.yMMMMd().format(entity.finishDate),
                style: context.textStyle.sfProRegular.copyWith(
                  fontSize: 14,
                  color: context.colors.ebebf5Color.withAlpha(80),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
