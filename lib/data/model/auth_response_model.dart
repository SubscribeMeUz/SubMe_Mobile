class AuthResponseModel {
  final String accessToken;
  final String refreshToken;

  const AuthResponseModel({required this.accessToken, required this.refreshToken});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
    );
  }
}
