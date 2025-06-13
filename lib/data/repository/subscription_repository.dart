import 'package:gym_pro/data/remote_source/subscription_remote_source.dart';
import 'package:gym_pro/domain/entity/subcription_entity.dart';
import 'package:gym_pro/domain/repository/subscription_repository.dart';

typedef TotalListCount = int;

class SubscriptionRepositoryImpl extends SubscriptionRepository {
  final SubscriptionRemoteSource remoteSource;

  SubscriptionRepositoryImpl({required this.remoteSource});

  @override
  Future<(List<SubscriptionEntity>, TotalListCount)> getAll() async {
    final res = await remoteSource.getSubscriptionList();

    return res.toListEntity;
  }

  @override
  Future<List<SubscriptionEntity>> getMySubscriptions() async {
    final res = await remoteSource.getMySubscriptions();

    return res.map((e) => e.toEntity).toList();
  }
}
