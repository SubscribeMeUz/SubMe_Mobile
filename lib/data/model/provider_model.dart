import 'package:gym_pro/domain/entity/provider_entity.dart';

class ProviderModel {
  int? id;
  String? logo;
  String? name;

  ProviderModel({this.id, this.logo, this.name});

  ProviderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logo = json['logo'];
    name = json['name'];
  }

  ProviderEntity get toEntity {
    return ProviderEntity(id: id ?? 0, logo: logo ?? '', name: name ?? '');
  }
}
