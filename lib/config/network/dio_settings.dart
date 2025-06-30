import 'dart:async';
import 'dart:io';

import 'package:chuck_interceptor/chuck_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gym_pro/config/constants/constants.dart';
import 'package:gym_pro/config/network/api_exception.dart';
import 'package:gym_pro/config/network/dio_interceptors.dart';
import 'package:gym_pro/config/router/router.dart';

import 'dio_connectivity_request_retrier.dart';

Chuck chuck = Chuck(
  showNotification: true,
  showInspectorOnShake: false,
  navigatorKey: rootNavigatorKey,
);

class DioSettings {
  late CustomDioInterceptor customInterceptor;

  final BaseOptions _dioBaseOptions = BaseOptions(
    baseUrl: Constants.baseUrl,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    followRedirects: false,
  );
  Dio? _dio;

  void removeChuckInterceptor() {
    _dio?.interceptors.removeWhere((element) => element is ChuckDioInterceptor);
  }

  void addChuckInterceptor() {
    _dio?.interceptors.add(chuck.dioInterceptor);
  }

  Dio _createInterceptorConfiguredClient({required String? baseUrl}) {
    if (_dio != null) {
      _dio?.options.baseUrl = Constants.baseUrl;
      return _dio!;
    }
    _dio = Dio(_dioBaseOptions);
    customInterceptor = CustomDioInterceptor(
      dio: _dio!,
      dioConnectivityRequestRetrier: DioConnectivityRequestRetrier(dio: _dio!),
    );

    if (baseUrl != null) {
      _dio?.options.baseUrl = baseUrl;
    }

    _dio!.interceptors.addAll([
      customInterceptor,
      if (kDebugMode) chuck.dioInterceptor,
      if (kDebugMode) ...[
        LogInterceptor(request: true, responseBody: true, error: true, requestBody: true),
      ],
    ]);
    return _dio!;
  }

  Future<dynamic> dioMethod(
    String uri,
    RESTMethodTypes methodType, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    String? customBaseUrl,
  }) async {
    try {
      late Response<dynamic> response;
      var dio = _createInterceptorConfiguredClient(baseUrl: customBaseUrl);
      switch (methodType) {
        case RESTMethodTypes.GET:
          response = await dio.get(
            uri,
            data: data,
            queryParameters: queryParameters,
            options: options,
          );
        case RESTMethodTypes.POST:
          response = await dio.post(
            uri,
            data: data,
            queryParameters: queryParameters,
            options: options,
          );
        case RESTMethodTypes.PATCH:
          response = await dio.patch(
            uri,
            data: data,
            queryParameters: queryParameters,
            options: options,
          );
        case RESTMethodTypes.PUT:
          response = await dio.put(
            uri,
            data: data,
            queryParameters: queryParameters,
            options: options,
          );
        case RESTMethodTypes.DELETE:
          response = await dio.delete(
            uri,
            data: data,
            queryParameters: queryParameters,
            options: options,
          );
      }
      return response.data;
    } on SocketException catch (_) {
      // throw const NoInternetFailure(
      //     message: "Please check your internet connection");
    } on TimeoutException catch (_) {
      // throw const NoInternetFailure(
      //     message: "Slow Speed. Please check your internet connection");
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 500:
          throw ApiException(
            requestOptions: e.requestOptions,
            errMessage: "Please try again later 500",
            statusCode: 500,
          );

        case 502:
          throw ApiException(
            requestOptions: e.requestOptions,
            errMessage: "Please try again later 502",
            statusCode: 502,
          );
        case 503:
          throw ApiException(
            requestOptions: e.requestOptions,
            errMessage: "Please try again later 503",
            statusCode: 503,
          );
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
