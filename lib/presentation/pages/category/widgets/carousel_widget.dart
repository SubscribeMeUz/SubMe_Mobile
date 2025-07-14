import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/presentation/bloc/abonements/abonement_bloc.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  final carouselController = CarouselSliderController();
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbonementBloc, AbonementState>(
      builder: (context, state) {
        return CarouselSlider(
          carouselController: carouselController,
          items: List.generate(state.providerDetailEntity?.images.length ?? 0, (index) {
            final item = state.providerDetailEntity?.images[index];
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: context.colors.cardDark,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(item ?? ''),
                ),
              ),
              margin: const EdgeInsets.only(right: 16),
            );
          }),
          options: CarouselOptions(
            height: 185,
            initialPage: _currentIndex,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
            viewportFraction: 0.85,
            scrollDirection: Axis.horizontal,
            enableInfiniteScroll: true,
          ),
        );
      },
    );
  }
}
