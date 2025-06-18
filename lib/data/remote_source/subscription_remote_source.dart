import 'package:gym_pro/config/constants/constants.dart';
import 'package:gym_pro/config/network/api_exception.dart';
import 'package:gym_pro/config/network/dio_settings.dart';
import 'package:gym_pro/data/model/my_abonement_list_model.dart';
import 'package:gym_pro/data/model/provider_abonements_model.dart';
import 'package:gym_pro/data/model/subscription_list_model.dart';

class SubscriptionRemoteSource {
  final DioSettings dio;

  const SubscriptionRemoteSource(this.dio);

  Future<SubscriptionListModel> getSubscriptionList() async {
    const getSubscriptionListApi = Constants.getSubscriptionListApi;

    final data = await dio.dioMethod(getSubscriptionListApi, RESTMethodTypes.GET);

    return SubscriptionListModel.fromJson(data);
  }

  Future<MyAbonementsListModel> getMySubscriptions() async {
    const mySubscriptions = Constants.mySubscriptionsListApi;

    final data = await dio.dioMethod(mySubscriptions, RESTMethodTypes.GET);

    return MyAbonementsListModel.fromJson(data);
  }

  Future<SubscriptionListModel> getSubscriptionDetail(int providerId) async {
    final subsDetail = '${Constants.subscriptionDetailApi}/$providerId';

    final data = await dio.dioMethod(subsDetail, RESTMethodTypes.GET);

    return SubscriptionListModel.fromJson(data);
  }

  Future<ProviderAbonementsModel> getTariffOfProviderId(int providerId) async {
    final tariffOfProvider = '${Constants.getAllTarifsOfProviderApi}/$providerId';

    final data = await dio.dioMethod(tariffOfProvider, RESTMethodTypes.GET);

    return ProviderAbonementsModel.fromJson(data);
  }
}
