import 'package:gym_pro/data/model/subscription_model.dart';
import 'package:gym_pro/data/repository/subscription_repository.dart';
import 'package:gym_pro/domain/entity/subcription_entity.dart';

class SubscriptionListModel {
  int? total;
  int? page;
  int? totalPage;
  int? limit;
  List<SubscriptionModel>? data;

  SubscriptionListModel({this.total, this.page, this.totalPage, this.limit, this.data});

  SubscriptionListModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    totalPage = json['total_page'];
    limit = json['limit'];
    if (json['data'] != null) {
      data = <SubscriptionModel>[];
      json['data'].forEach((v) {
        data!.add(SubscriptionModel.fromJson(v));
      });
    }
  }

  (List<SubscriptionEntity>, TotalListCount) get toListEntity {
    return ((data?.map((e) => e.toEntity).toList() ?? []), total ?? 0);
  }
}
