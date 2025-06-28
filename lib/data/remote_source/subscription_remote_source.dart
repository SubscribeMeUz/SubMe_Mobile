import 'package:gym_pro/config/constants/constants.dart';
import 'package:gym_pro/config/network/api_exception.dart';
import 'package:gym_pro/config/network/dio_settings.dart';
import 'package:gym_pro/data/model/abonement_model.dart';
import 'package:gym_pro/data/model/provider_abonements_model.dart';
import 'package:gym_pro/data/model/provider_model.dart';
import 'package:gym_pro/data/model/subscription_model.dart';

class SubscriptionRemoteSource {
  final DioSettings dio;

  const SubscriptionRemoteSource(this.dio);

  Future<List<ProviderModel>> getProviderList() async {
    const getSubscriptionListApi = Constants.getSubscriptionListApi;

    final data = await dio.dioMethod(getSubscriptionListApi, RESTMethodTypes.GET);

    return (data as List).map((e) => ProviderModel.fromJson(e)).toList();
  }

  Future<List<MyAbonementModel>> getMySubscriptions() async {
    const mySubscriptions = Constants.mySubscriptionsListApi;

    final data = await dio.dioMethod(mySubscriptions, RESTMethodTypes.GET);

    return (data as List).map((e) => MyAbonementModel.fromJson(e)).toList();
  }

  Future<SubscriptionModel> getSubscriptionDetail(int providerId) async {
    final subsDetail = '${Constants.subscriptionDetailApi}/$providerId';

    final data = await dio.dioMethod(subsDetail, RESTMethodTypes.GET);

    return SubscriptionModel.fromJson(data);
  }

  Future<ProviderAbonementsModel> getTariffOfProviderId(int providerId) async {
    final tariffOfProvider = '${Constants.getAllTarifsOfProviderApi}/$providerId';

    final data = await dio.dioMethod(tariffOfProvider, RESTMethodTypes.GET);

    return ProviderAbonementsModel.fromJson(data);
  }

  Future<void> purchaseAbonement(int abonementId) async {
    final purchaseApi = Constants.purchaseApi;

    await dio.dioMethod(purchaseApi, RESTMethodTypes.POST, data: {'aboniment_id': abonementId});
  }
}
