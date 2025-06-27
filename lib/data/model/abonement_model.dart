import 'package:gym_pro/domain/entity/my_subscription_entity.dart';
import 'package:gym_pro/config/extensions/main_extensions.dart';

class MyAbonementModel {
  int? id;
  int? totalCount;
  int? aviableCount;
  String? expireDate;
  String? purchasedDate;
  int? expiryDays;

  Provider? provider;

  MyAbonementModel({
    this.id,
    this.expiryDays,
    this.provider,
    this.aviableCount,
    this.expireDate,
    this.purchasedDate,
    this.totalCount,
  });

  MyAbonementModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalCount = json['total_count'];
    aviableCount = json['aviable_count'];
    expireDate = json['expire_date'];
    expiryDays = json['expiry_days'];
    purchasedDate = json['purchased_date'];
    provider = json['provider'] != null ? Provider.fromJson(json['provider']) : null;
  }

  MySubscriptionEntity get toEntity {
    //TODO change when api is ready
    final expireTime = expireDate.toDateTime();
    return MySubscriptionEntity(
      id: id ?? 0,
      providerId: provider?.id ?? 0,
      name: provider?.name ?? '',
      leftDays: expireTime!.difference(DateTime.now()).inDays,
      logoUrl: provider?.logoUrl ?? '',
      isPopular: false,
      period: '$expiryDays',
      finishDate: expireTime,
      totalCount: totalCount ?? 0,
      leftCount: aviableCount ?? 0,
    );
  }
}

class Provider {
  int? id;
  String? name;
  String? logoUrl;

  Provider({this.id, this.name});

  Provider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logoUrl = json['logo_url'];
  }
}
