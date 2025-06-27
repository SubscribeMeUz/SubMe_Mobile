import 'dart:convert';

import 'package:gym_pro/config/constants/constants.dart';
import 'package:gym_pro/config/network/api_exception.dart';
import 'package:gym_pro/config/network/dio_settings.dart';
import 'package:gym_pro/data/model/abonement_model.dart';
import 'package:gym_pro/data/model/my_abonement_list_model.dart';
import 'package:gym_pro/data/model/provider_abonements_model.dart';
import 'package:gym_pro/data/model/subscription_list_model.dart';
import 'package:gym_pro/data/model/subscription_model.dart';

class SubscriptionRemoteSource {
  final DioSettings dio;

  const SubscriptionRemoteSource(this.dio);

  Future<SubscriptionListModel> getSubscriptionList() async {
    const getSubscriptionListApi = Constants.getSubscriptionListApi;

    final data = await dio.dioMethod(getSubscriptionListApi, RESTMethodTypes.GET);

    return SubscriptionListModel.fromJson(data);
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

    const a = '''{
  "id": 7,
  "title": "GymPro",
  "logo": "http://193.124.115.127:8000/images/44974e3e-f29e-459b-92da-a40e3221aad6-photo_2025-06-24_16-27-35.jpg",
  "tabs": [
    {
      "label": "Man",
      "value": "man"
    },
    {
      "label": "Woman",
      "value": "woman"
    }
  ],
  "plansByTab": {
    "man": [
      {
        "title": "Daytime (06:00 - 11:00)",
        "options": [
          {
            "id": 1,
            "plan_name": "Trial",
            "label": "Free",
            "title": "7 days",
            "subtitle": "Free trial subscription"
          },
          {
            "id": 7,
            "plan_name": "Start",
            "label": "Start",
            "title": "1 month",
            "subtitle": "Start subcription"
          }
        ]
      },
      {
        "title": "Afternoon (12:00 - 17:00)",
        "options": [
          {
            "id": 2,
            "plan_name": "Trial",
            "label": "Free",
            "title": "7 days",
            "subtitle": "Free trial subscription"
          },
          {
            "id": 8,
            "plan_name": "Start",
            "label": "Start",
            "title": "500 000",
            "subtitle": "1-month subcription"
          }
        ]
      },
      {
        "title": "Evening (18:00 - 00:00)",
        "options": [
          {
            "id": 3,
            "plan_name": "Trial",
            "label": "Free",
            "title": "7 days",
            "subtitle": "Free trial subscription"
          },
          {
            "id": 9,
            "plan_name": "Start",
            "label": "Start",
            "title": "1 month",
            "subtitle": "Start subcription"
          }
        ]
      }
    ],
    "woman": [
      {
        "title": "Daytime (06:00 - 11:00)",
        "options": [
          {
            "id": 4,
            "plan_name": "Trial",
            "label": "Free",
            "title": "7 days",
            "subtitle": "Free trial subscription"
          },
          {
            "id": 10,
            "plan_name": "Start",
            "label": "Start",
            "title": "690 000",
            "subtitle": "Start subcription"
          }
        ]
      },
      {
        "title": "Afternoon (12:00 - 17:00)",
        "options": [
          {
            "id": 5,
            "plan_name": "Trial",
            "label": "Free",
            "title": "7 days",
            "subtitle": "Free trial subscription"
          },
          {
            "id": 11,
            "plan_name": "Start",
            "label": "Start",
            "title": "1 month",
            "subtitle": "Start subcription"
          }
        ]
      },
      {
        "title": "Evening (18:00 - 00:00)",
        "options": [
          {
            "id": 6,
            "plan_name": "Trial",
            "label": "Free",
            "title": "7 days",
            "subtitle": "Free trial subscription"
          },
          {
            "id": 12,
            "plan_name": "Start",
            "label": "Start",
            "title": "1 month",
            "subtitle": "Start subcription"
          }
        ]
      }
    ]
  }
}''';
    final data = jsonDecode(a);

    return ProviderAbonementsModel.fromJson(data);

    // final data = await dio.dioMethod(tariffOfProvider, RESTMethodTypes.GET);

    // return ProviderAbonementsModel.fromJson(data);
  }
}
