import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gym_pro/domain/entity/subcription_entity.dart';

class SubscriptionModel {
  int? id;
  String? name;
  String? locationLatt;
  String? locationLong;
  String? necessaryTools;
  String? logoUrl;
  Owner? owner;
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
  });

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    locationLatt = json['location_latt'];
    locationLong = json['location_long'];
    necessaryTools = json['necessary_tools'];
    logoUrl = json['logo_url'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
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
    );
  }
}

class Owner {
  int? id;
  String? username;
  String? phone;
  String? fullName;
  String? role;

  Owner({this.id, this.username, this.phone, this.fullName, this.role});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    phone = json['phone'];
    fullName = json['full_name'];
    role = json['role'];
  }
}
