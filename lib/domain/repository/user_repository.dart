import 'package:gym_pro/data/model/request/update_user_model.dart';
import 'package:gym_pro/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getUser();
  Future<void> updateUser(UpdateUserModel updateUserModel);
}
