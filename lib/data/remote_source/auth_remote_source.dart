import 'package:gym_pro/config/constants/constants.dart';
import 'package:gym_pro/config/network/api_exception.dart';
import 'package:gym_pro/config/network/dio_settings.dart';
import 'package:gym_pro/data/model/auth_response_model.dart';

class AuthRemoteSource {
  final DioSettings dio;

  AuthRemoteSource({required this.dio});

  Future<void> userLogin(String phone) async {
    const loginUrl = Constants.loginApi;

    await dio.dioMethod(
      loginUrl,
      RESTMethodTypes.POST,
      data: {'phone': phone, 'username': '', 'full_name': ''},
    );
  }

  Future<AuthResponseModel> verifyOtp(String phone, String otp) async {
    const loginUrl = Constants.verifyAuthApi;

    final response = await dio.dioMethod(
      loginUrl,
      RESTMethodTypes.POST,

      //TODO uncomment if back changes
      // data: {'phone': phone, 'otp': otp},
      data: {'phone': phone, 'code': '123456'},
    );

    return AuthResponseModel.fromJson(response);
  }
}
