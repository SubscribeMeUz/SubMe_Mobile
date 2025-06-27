import 'package:gym_pro/data/repository/subscription_repository.dart';
import 'package:gym_pro/domain/entity/my_subscription_entity.dart';
import 'package:gym_pro/domain/entity/provider_abonements_entity.dart';
import 'package:gym_pro/domain/entity/subcription_entity.dart';

abstract class SubscriptionRepository {
  Future<(List<SubscriptionEntity>, TotalListCount)> getAll();
  Future<List<MySubscriptionEntity>> getMySubscriptions();
  Future<SubscriptionEntity> getProviderDetail(int providerId);
  Future<ProviderAbonementsEntity> getProviderTariffs(int providerId);
}
