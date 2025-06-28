class UpdateUserModel {
  final String username;
  final String? password;
  final String? newPassword;
  final String phone;
  final String fullName;

  UpdateUserModel({
    required this.username,
    required this.phone,
    required this.fullName,
    this.password,
    this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "new_password": newPassword,
      "phone": phone,
      "full_name": fullName,
    };
  }
}
