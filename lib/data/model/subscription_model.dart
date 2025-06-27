import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gym_pro/data/model/owner_model.dart';
import 'package:gym_pro/domain/entity/subcription_entity.dart';

class SubscriptionModel {
  int? id;
  String? name;
  String? locationLatt;
  String? locationLong;
  String? necessaryTools;
  String? logoUrl;
  List<int?>? discounts;
  OwnerModel? owner;
  String? registredDate;

  SubscriptionModel({
    this.id,
    this.name,
    this.locationLatt,
    this.locationLong,
    this.necessaryTools,
    this.logoUrl,
    this.owner,
    this.registredDate,
    this.discounts,
  });

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    locationLatt = json['location_latt'];
    locationLong = json['location_long'];
    necessaryTools = json['necessary_tools'];
    logoUrl = json['logo'];
    discounts = json['discounts'].cast<int?>();
    owner = json['owner'] != null ? OwnerModel.fromJson(json['owner']) : null;
    registredDate = json['registred_date'];
  }

  SubscriptionEntity get toEntity {
    late final double latitude;
    late final double longitude;
    if (locationLatt != null && locationLong != null) {
      latitude = double.parse(locationLatt!);
      longitude = double.parse(locationLong!);
    }
    return SubscriptionEntity(
      id: id ?? 0,
      name: name ?? '',
      logoUrl: logoUrl,
      latLng: LatLng(latitude, longitude),
      necessaryTools: necessaryTools,
      discount:
          (discounts != null && discounts?.isNotEmpty == true)
              ? (discounts!.map((e) => e!.toInt()).toList()).reduce(max).toDouble()
              : null,
    );
  }
}
