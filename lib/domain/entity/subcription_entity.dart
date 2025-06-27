import 'package:google_maps_flutter/google_maps_flutter.dart';

class SubscriptionEntity {
  final int id;
  final String name;
  final String? logoUrl;
  final LatLng? latLng;
  final String? necessaryTools;
  final double? discount;

  const SubscriptionEntity({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.latLng,
    required this.necessaryTools,
    required this.discount,
  });
}
