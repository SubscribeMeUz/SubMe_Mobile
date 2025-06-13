import 'package:gym_pro/data/repository/subscription_repository.dart';
import 'package:gym_pro/domain/entity/subcription_entity.dart';

abstract class SubscriptionRepository {
  Future<(List<SubscriptionEntity>, TotalListCount)> getAll();
  Future<List<SubscriptionEntity>> getMySubscriptions();
}
