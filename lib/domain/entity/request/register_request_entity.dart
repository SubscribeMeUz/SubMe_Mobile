class RegisterRequestEntity {
  final String username;
  final String phoneNumber;
  final String password;
  final String confirmPassword;

  const RegisterRequestEntity({
    required this.username,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  });
}
