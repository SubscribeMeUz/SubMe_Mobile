import 'package:gym_pro/domain/entity/user_entity.dart';

class UserModel {
  int? id;
  String? username;
  String? phone;
  String? fullName;
  String? role;

  UserModel({this.id, this.username, this.phone, this.fullName, this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    phone = json['phone'];
    fullName = json['full_name'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['full_name'] = this.fullName;
    data['role'] = this.role;
    return data;
  }

  UserEntity get toEntity {
    return UserEntity(userId: id ?? 0, username: username, phone: phone ?? '', fullName: fullName);
  }
}
