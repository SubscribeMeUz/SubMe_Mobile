class OwnerModel {
  int? id;
  String? username;
  String? phone;
  String? fullName;
  String? role;

  OwnerModel({this.id, this.username, this.phone, this.fullName, this.role});

  OwnerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    phone = json['phone'];
    fullName = json['full_name'];
    role = json['role'];
  }
}
