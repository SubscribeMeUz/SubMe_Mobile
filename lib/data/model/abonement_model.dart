import 'package:gym_pro/data/model/owner_model.dart';
import 'package:gym_pro/domain/entity/my_subscription_entity.dart';

class AbonementModel {
  int? id;
  String? name;
  int? count;
  int? price;
  int? expiryDays;
  List<String>? availableDays;
  WorkingHours? workingHours;
  int? providerId;
  Provider? provider;

  AbonementModel({
    this.id,
    this.name,
    this.count,
    this.price,
    this.expiryDays,
    this.availableDays,
    this.workingHours,
    this.providerId,
    this.provider,
  });

  AbonementModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    count = json['count'];
    price = json['price'];
    expiryDays = json['expiry_days'];
    availableDays = json['available_days'].cast<String>();
    workingHours =
        json['working_hours'] != null ? WorkingHours.fromJson(json['working_hours']) : null;
    providerId = json['provider_id'];
    provider = json['provider'] != null ? Provider.fromJson(json['provider']) : null;
  }

  MySubscriptionEntity get toEntity {
    //TODO change when api is ready
    final expireTime = DateTime.now().add(Duration(days: 20));
    return MySubscriptionEntity(
      id: id ?? 0,
      providerId: providerId ?? 0,
      name: name ?? '',
      leftDays: expireTime.difference(DateTime.now()).inDays,
      logoUrl:
          'http://193.124.115.127:8000/images/3f0aa6ba-f0f4-465c-a56d-5fc88bc71d50-photo_2025-06-09_16-46-42.jpg',
      isPopular: false,
      period: '$expiryDays',
      finishDate: expireTime,
    );
  }
}

class WorkingHours {
  String? s1;
  String? s2;
  String? s3;

  WorkingHours({this.s1, this.s2, this.s3});

  WorkingHours.fromJson(Map<String, dynamic> json) {
    s1 = json['1'];
    s2 = json['2'];
    s3 = json['3'];
  }
}

class Provider {
  int? id;
  String? name;
  OwnerModel? owner;
  String? registredDate;

  Provider({this.id, this.name, this.owner, this.registredDate});

  Provider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    owner = json['owner'] != null ? OwnerModel.fromJson(json['owner']) : null;
    registredDate = json['registred_date'];
  }
}
