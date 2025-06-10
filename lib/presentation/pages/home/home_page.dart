import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gym_pro/config/style/app_colors.dart';

class Abonement {
  final String name;
  final String imageUrl;
  final int availableVisits;
  final int peopleInGym;
  final String city;
  final String street;
  final double rate;
  final double price;
  final int totalMonthlyVisits;

  Abonement({
    required this.name,
    required this.imageUrl,
    required this.availableVisits,
    required this.peopleInGym,
    this.city = '',
    this.street = '',
    this.rate = 0,
    this.price = 0,
    this.totalMonthlyVisits = 0,
  });
}

const imageurl =
    "https://landmarksarchitects.com/wp-content/uploads/2024/04/Functionality-and-Space-Planning-03.04.2024.jpg";

class HomePage extends StatelessWidget {
  final List<Abonement> myAbonements = [
    Abonement(name: 'Fitness Pro', imageUrl: imageurl, availableVisits: 12, peopleInGym: 20),
    Abonement(name: 'Gym Max', imageUrl: imageurl, availableVisits: 8, peopleInGym: 18),
    Abonement(name: 'Active Life', imageUrl: imageurl, availableVisits: 10, peopleInGym: 25),
  ];

  final List<Abonement> otherAbonements = [
    Abonement(
      name: 'Ultra Fitness',
      imageUrl: imageurl,
      availableVisits: 0,
      peopleInGym: 0,
      city: 'New York',
      street: '5th Avenue',
      rate: 4.8,
      price: 49.99,
      totalMonthlyVisits: 30,
    ),
    Abonement(
      name: 'Sport Zone',
      imageUrl: imageurl,
      availableVisits: 0,
      peopleInGym: 0,
      city: 'Los Angeles',
      street: 'Sunset Blvd',
      rate: 4.5,
      price: 39.99,
      totalMonthlyVisits: 25,
    ),
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopBar(),
            const SizedBox(height: 16),
            _buildSection('My abonements', myAbonements),
            const SizedBox(height: 24),
            Expanded(child: _buildVerticalListSection('Other abonements', otherAbonements)),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
          IconButton(icon: const Icon(Icons.person_outline), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Abonement> abonements) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 230,
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            physics: BouncingScrollPhysics(),
            itemCount: abonements.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => Gap(12),
            itemBuilder: (context, index) {
              return _buildAbonementCard(context, abonements[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAbonementCard(BuildContext context, Abonement abonement) {
    return Container(
      width: 170,
      decoration: BoxDecoration(
        color: context.colors.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: CachedNetworkImage(
              imageUrl:
                  'https://landmarksarchitects.com/wp-content/uploads/2024/04/Functionality-and-Space-Planning-03.04.2024.jpg',
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  abonement.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Gap(8),
                Text("${abonement.availableVisits} available visits"),
                Text("${abonement.peopleInGym} people in gym"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalListSection(String title, List<Abonement> abonements) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              itemCount: abonements.length,
              separatorBuilder: (context, index) => Gap(16),
              itemBuilder: (context, index) {
                final ab = abonements[index];
                return Container(
                  decoration: BoxDecoration(
                    color: context.colors.backgroundColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 1,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://landmarksarchitects.com/wp-content/uploads/2024/04/Functionality-and-Space-Planning-03.04.2024.jpg',
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ab.name,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${ab.city}, ${ab.street}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber, size: 16),
                                  Text('${ab.rate}', style: const TextStyle(fontSize: 14)),
                                  const SizedBox(width: 12),
                                  Text(
                                    '\$${ab.price.toStringAsFixed(2)}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Monthly visits: ${ab.totalMonthlyVisits}',
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
