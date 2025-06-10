abstract class AuthRepository {
  Future<void> userLogin(String phone);
  Future<void> verifyOtp(String phone, String otpCode);
}
