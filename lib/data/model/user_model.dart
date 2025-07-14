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
    data['id'] = id;
    data['username'] = username;
    data['phone'] = phone;
    data['full_name'] = fullName;
    data['role'] = role;
    return data;
  }

  UserEntity get toEntity {
    return UserEntity(userId: id ?? 0, username: username, phone: phone ?? '', fullName: fullName);
  }
}
