import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gym_pro/components/bottom_button_bar.dart';
import 'package:gym_pro/components/custom_app_bar.dart';
import 'package:gym_pro/components/tab_widget.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:gym_pro/domain/entity/provider_abonements_entity.dart';
import 'package:gym_pro/presentation/pages/category/widgets/abonements/abonement_widget.dart';

class AbonementsPage extends StatefulWidget {
  final ProviderAbonementsEntity? entity;
  const AbonementsPage({super.key, this.entity});

  @override
  State<AbonementsPage> createState() => _AbonementsPageState();
}

class _AbonementsPageState extends State<AbonementsPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    //TODO length should be dynamic
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.modalDark,
      appBar: CustomAppBar(),
      bottomNavigationBar: BottomButtonBar(
        backgroundColor: context.colors.modalDark,
        buttonText: 'Buy subscription',
        onTap: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
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
                          'https://landmarksarchitects.com/wp-content/uploads/2024/04/Functionality-and-Space-Planning-03.04.2024.jpg',
                          maxHeight: 80,
                          maxWidth: 80,
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Text(
                    'Lemon Gym',
                    style: context.textStyle.sfProSemiBold.copyWith(
                      color: context.colors.whiteColor,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            const SliverGap(24),
            SliverToBoxAdapter(
              child: TabWidget(
                tabController: _tabController,
                tabs: [Tab(text: 'Man'), Tab(text: 'Woman')],
              ),
            ),
            const SliverGap(24),
            SliverToBoxAdapter(
              child: AbonementWidget(
                isHorizontal: true,
                chosenIndex: 0,
                blocks: [
                  AbonementBlock(
                    title: 'Daytime (06:00 - 11:00)',
                    options: [
                      AbonementOptionEntity(
                        id: 1,
                        planName: 'Trial',
                        subtitle: 'Free trial subscription',
                        title: '7 days',
                        label: 'Free',
                      ),
                      AbonementOptionEntity(
                        id: 1,
                        planName: 'Start',
                        subtitle: '1-Month Subscription',
                        title: '690 000',
                      ),
                      AbonementOptionEntity(
                        id: 1,
                        planName: 'Start 2',
                        subtitle: '2-Month Subscription',
                        title: '1 000 000',
                      ),
                    ],
                  ),

                  AbonementBlock(
                    title: 'Afternoon (06:00 - 11:00)',
                    options: [
                      AbonementOptionEntity(
                        id: 1,
                        planName: 'Trial',
                        subtitle: 'Free trial subscription',
                        title: '7 days',
                        label: 'Free',
                      ),
                      AbonementOptionEntity(
                        id: 1,
                        planName: 'Start',
                        subtitle: '1-Month Subscription',
                        title: '690 000',
                      ),
                      AbonementOptionEntity(
                        id: 1,
                        planName: 'Start 2',
                        subtitle: '2-Month Subscription',
                        title: '1 000 000',
                      ),
                    ],
                  ),
                  AbonementBlock(
                    title: 'Daytime (06:00 - 11:00)',
                    options: [
                      AbonementOptionEntity(
                        id: 1,
                        planName: 'Trial',
                        subtitle: 'Free trial subscription',
                        title: '7 days',
                        label: 'Free',
                      ),
                      AbonementOptionEntity(
                        id: 1,
                        planName: 'Start',
                        subtitle: '1-Month Subscription',
                        title: '690 000',
                      ),
                      AbonementOptionEntity(
                        id: 1,
                        planName: 'Start 2',
                        subtitle: '2-Month Subscription',
                        title: '1 000 000',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
