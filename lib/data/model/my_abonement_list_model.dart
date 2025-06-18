import 'package:gym_pro/data/model/abonement_model.dart';
import 'package:gym_pro/data/repository/subscription_repository.dart';
import 'package:gym_pro/domain/entity/my_subscription_entity.dart';

class MyAbonementsListModel {
  int? total;
  int? totalPages;
  int? page;
  int? limit;
  List<AbonementModel>? data;

  MyAbonementsListModel({this.total, this.totalPages, this.page, this.limit, this.data});

  MyAbonementsListModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalPages = json['total_pages'];
    page = json['page'];
    limit = json['limit'];
    if (json['data'] != null) {
      data = <AbonementModel>[];
      json['data'].forEach((v) {
        data!.add(AbonementModel.fromJson(v));
      });
    }
  }

  (List<MySubscriptionEntity>, TotalListCount) get toListEntity {
    return ((data?.map((e) => e.toEntity).toList() ?? []), total ?? 0);
  }
}
