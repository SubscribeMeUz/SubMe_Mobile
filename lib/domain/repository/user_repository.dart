import 'package:gym_pro/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getUser();
  Future<void> updateUser(String? username, String? phone, String? fullname);
}
