import 'package:gym_pro/config/cache/cache_keys.dart';
import 'package:gym_pro/config/cache/local_storage.dart';
import 'package:gym_pro/data/remote_source/auth_remote_source.dart';
import 'package:gym_pro/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteSource remoteSource;

  AuthRepositoryImpl({required this.remoteSource});

  @override
  Future<void> userLogin(String phone) async {
    await remoteSource.userLogin(phone);
  }

  @override
  Future<void> verifyOtp(String phone, String otpCode) async {
    final response = await remoteSource.verifyOtp(phone, otpCode);

    await LocalStorage.putString(CacheKeys.accessToken, response.accessToken);
    await LocalStorage.putString(CacheKeys.refreshToken, response.refreshToken);
  }
}
