import 'package:gym_pro/config/constants/constants.dart';
import 'package:gym_pro/config/network/api_exception.dart';
import 'package:gym_pro/config/network/dio_settings.dart';
import 'package:gym_pro/data/model/request/update_user_model.dart';
import 'package:gym_pro/data/model/user_model.dart';

class UserRemoteSource {
  final DioSettings dio;

  UserRemoteSource({required this.dio});

  Future<UserModel> getUser() async {
    final userDataUrl = Constants.userApi;

    final data = await dio.dioMethod(userDataUrl, RESTMethodTypes.GET);

    return UserModel.fromJson(data);
  }

  Future<void> updateUser(UpdateUserModel updateModel) async {
    final userUpdate = Constants.updateUserApi;

    await dio.dioMethod(userUpdate, RESTMethodTypes.PUT, data: updateModel.toJson());
  }
}
