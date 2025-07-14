import 'package:flutter/rendering.dart';
import 'package:gym_pro/config/cache/cache_keys.dart';
import 'package:gym_pro/config/cache/local_storage.dart';
import 'package:gym_pro/data/model/request/update_user_model.dart';
import 'package:gym_pro/data/remote_source/user_remote_source.dart';
import 'package:gym_pro/domain/entity/user_entity.dart';
import 'package:gym_pro/domain/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteSource remoteSource;

  UserRepositoryImpl({required this.remoteSource});

  @override
  Future<UserEntity> getUser() async {
    final data = await remoteSource.getUser();

    final userEntity = data.toEntity;

    try {
      await LocalStorage.putInt(CacheKeys.userId, userEntity.userId);
      await LocalStorage.putString(CacheKeys.phoneNumber, userEntity.phone);
      await LocalStorage.putString(CacheKeys.fullname, userEntity.fullName ?? '');
    } catch (e) {
      debugPrint('error saving userdata $e');
    }

    return userEntity;
  }

  @override
  Future<void> updateUser(String? username, String? phone, String? fullname) async {
    final updateModel = UpdateUserModel(username: username, phone: phone, fullName: fullname);

    await remoteSource.updateUser(updateModel);

    if (phone != null) {
      await LocalStorage.putString(CacheKeys.phoneNumber, phone);
    }
    if (fullname != null) {
      await LocalStorage.putString(CacheKeys.fullname, fullname);
    }
  }
}
