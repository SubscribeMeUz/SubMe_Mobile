import 'package:gym_pro/data/remote_source/subscription_remote_source.dart';
import 'package:gym_pro/domain/entity/my_subscription_entity.dart';
import 'package:gym_pro/domain/entity/provider_abonements_entity.dart';
import 'package:gym_pro/domain/entity/provider_entity.dart';
import 'package:gym_pro/domain/entity/subcription_entity.dart';
import 'package:gym_pro/domain/repository/subscription_repository.dart';

typedef TotalListCount = int;

class SubscriptionRepositoryImpl extends SubscriptionRepository {
  final SubscriptionRemoteSource remoteSource;

  SubscriptionRepositoryImpl({required this.remoteSource});

  @override
  Future<List<ProviderEntity>> getAllProvider() async {
    final providerList = await remoteSource.getProviderList();

    return providerList.map((e) => e.toEntity).toList();
  }

  @override
  Future<List<MySubscriptionEntity>> getMySubscriptions() async {
    final res = await remoteSource.getMySubscriptions();

    return res.map((e) => e.toEntity).toList();
  }

  @override
  Future<SubscriptionEntity> getProviderDetail(int providerId) async {
    final res = await remoteSource.getSubscriptionDetail(providerId);

    return res.toEntity;
  }

  @override
  Future<ProviderAbonementsEntity> getProviderTariffs(int providerId) async {
    final res = await remoteSource.getTariffOfProviderId(providerId);

    return res.toEntity;
  }
}
