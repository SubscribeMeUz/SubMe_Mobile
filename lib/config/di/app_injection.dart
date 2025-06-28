import 'package:get_it/get_it.dart';
import 'package:gym_pro/config/cache/local_storage.dart';
import 'package:gym_pro/config/network/dio_settings.dart';
import 'package:gym_pro/data/remote_source/auth_remote_source.dart';
import 'package:gym_pro/data/remote_source/subscription_remote_source.dart';
import 'package:gym_pro/data/remote_source/user_remote_source.dart';
import 'package:gym_pro/data/repository/auth_repository.dart';
import 'package:gym_pro/data/repository/subscription_repository.dart';
import 'package:gym_pro/data/repository/user_repository.dart';
import 'package:gym_pro/domain/repository/auth_repository.dart';
import 'package:gym_pro/domain/repository/subscription_repository.dart';
import 'package:gym_pro/domain/repository/user_repository.dart';

final getIt = GetIt.instance;

class Injector {
  Future<void> setServices() async {
    await regiterSharedData();
    registerNetworkServices();
    registerDatasources();
    registerRepositories();
  }

  Future<void> regiterSharedData() async {
    getIt.registerSingleton<LocalStorage>(await LocalStorage.getInstance());
  }

  void registerNetworkServices() {
    getIt.registerLazySingleton<DioSettings>(() => DioSettings());
  }

  void registerDatasources() {
    getIt.registerLazySingleton<AuthRemoteSource>(() => AuthRemoteSource(dio: getIt.get()));

    getIt.registerLazySingleton<SubscriptionRemoteSource>(
      () => SubscriptionRemoteSource(getIt.get()),
    );

    getIt.registerLazySingleton<UserRemoteSource>(() => UserRemoteSource(dio: getIt.get()));
  }

  void registerRepositories() {
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteSource: getIt.get()),
    );
    getIt.registerLazySingleton<SubscriptionRepository>(
      () => SubscriptionRepositoryImpl(remoteSource: getIt.get()),
    );
    getIt.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteSource: getIt.get()),
    );
  }
}
