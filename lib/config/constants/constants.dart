//urls

class Constants {
  static const String baseUrl = 'BASE_URL';
  static const String loginApi = 'user/auth/request-otp';
  static const String verifyAuthApi = 'user/auth/verify-otp';
  static const String getSubscriptionListApi = 'app/providers/get/all';
  static const String subscriptionDetailApi = 'app/providers/get';
  static const String mySubscriptionsListApi = 'new-aboniments/get/my-aboniments';
  static const String getAllTarifsOfProviderApi = 'new-aboniments/get/by-provider';
  static const String refreshTokenApi = 'user/auth/refresh';
  static const String userApi = 'user/get-me';
  static const String updateUserApi = 'user/self-change';
  static const String purchaseApi = 'purchasing-requests/add';
  static const String visitViaQrApi = 'visitations/add';
}
