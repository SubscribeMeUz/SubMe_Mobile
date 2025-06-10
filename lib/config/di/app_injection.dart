import 'package:get_it/get_it.dart';
import 'package:gym_pro/config/cache/local_storage.dart';
import 'package:gym_pro/config/network/dio_settings.dart';
import 'package:gym_pro/data/remote_source/auth_remote_source.dart';
import 'package:gym_pro/data/repository/auth_repository.dart';
import 'package:gym_pro/domain/repository/auth_repository.dart';

final getIt = GetIt.instance;

class Injector {
  Future<void> setServices() async {
    await regiterSharedData();
    registerNetworkServices();
    registerDatasources();
    registerRepositories();
    registerUseCases();
    registerBlocs();
  }

  Future<void> regiterSharedData() async {
    getIt.registerSingleton<LocalStorage>(await LocalStorage.getInstance());
  }

  void registerNetworkServices() {
    getIt.registerLazySingleton<DioSettings>(() => DioSettings());
  }

  void registerDatasources() {
    getIt.registerLazySingleton<AuthRemoteSource>(() => AuthRemoteSource(dio: getIt.get()));
  }

  void registerRepositories() {
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteSource: getIt.get()),
    );
  }

  void registerUseCases() {}

  void registerBlocs() {}
}
