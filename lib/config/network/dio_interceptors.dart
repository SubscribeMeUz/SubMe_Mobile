import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gym_pro/config/cache/cache_keys.dart';
import 'package:gym_pro/config/cache/local_storage.dart';
import 'package:gym_pro/config/constants/constants.dart';
import 'package:gym_pro/config/mixin/logout_mixin.dart';
import 'package:gym_pro/config/network/api_exception.dart';
import 'package:gym_pro/config/network/dio_connectivity_request_retrier.dart';

bool isRefreshingToken = false;

List<Map<dynamic, dynamic>> failedRequests = [];

class CustomDioInterceptor extends Interceptor with LogoutMixin {
  final DioConnectivityRequestRetrier dioConnectivityRequestRetrier;

  CustomDioInterceptor({required this.dio, required this.dioConnectivityRequestRetrier});

  Dio dio;

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = LocalStorage.getString(CacheKeys.accessToken);

    options.headers['Authorization'] = 'Bearer $accessToken';

    return super.onRequest(options, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint(
      "exception....${err.type} ${err.message} ${err.runtimeType} code ${err.response?.statusCode} ${err.requestOptions.path}",
    );
    debugPrint("error data ${err.response?.data}");
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.error is SocketException) {
      try {
        Response response = await dioConnectivityRequestRetrier.scheduleRequestRetry(
          err.requestOptions,
        );
        return handler.resolve(response);
      } catch (e) {
        return super.onError(err, handler);
      }
    }
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      await refreshAndSaveParallelRequests(err.requestOptions, handler);
    } else {
      try {
        var serverFailure = ApiException.detailed(
          requestOptions: err.requestOptions,
          parameters: err.requestOptions.queryParameters,
          endpoint: err.requestOptions.path,
          response: err.response?.data,
          statusCode: err.response?.statusCode,
        );
        return super.onError(serverFailure, handler);
      } catch (e) {
        return super.onError(err, handler);
      }
    }
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    return super.onResponse(response, handler);
  }

  refreshAndSaveParallelRequests(RequestOptions requestOptions, handler) async {
    if (!isRefreshingToken) {
      isRefreshingToken = true;
      failedRequests.add({'requestOption': requestOptions, 'handler': handler});
      final isSuccess = await refreshTokenRequest(requestOptions);
      isRefreshingToken = false;

      if (isSuccess) {
        for (var req in failedRequests) {
          var cloneReq = await _retry(req["requestOption"]);
          req["handler"].resolve(cloneReq);
        }

        return;
      }
    } else {
      failedRequests.add({'requestOption': requestOptions, 'handler': handler});
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(method: requestOptions.method, headers: requestOptions.headers);

    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Future<bool> refreshTokenRequest(RequestOptions requestOptions) async {
    final options = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    final dio = Dio(options);
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(request: true, responseBody: true, error: true, requestBody: true),
      );
    }
    try {
      log("Refresh token request sent...");

      final response = await dio.post(
        Constants.refreshTokenApi,

        data: {"refresh_token": LocalStorage.getString(CacheKeys.refreshToken)},
      );
      final data = response.data as Map<String, dynamic>;
      await LocalStorage.putString(CacheKeys.accessToken, data['access_token']);
      await LocalStorage.putString(CacheKeys.refreshToken, data['refresh_token']);
      return true;
    } catch (e) {
      await logout();

      return false;
    }
  }
}
