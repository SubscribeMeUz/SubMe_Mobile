// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';

enum RESTMethodTypes {
  GET(parameterRepresentation: 'GET'),
  POST(parameterRepresentation: 'POST'),
  PATCH(parameterRepresentation: 'PATCH'),
  PUT(parameterRepresentation: 'PUT'),
  DELETE(parameterRepresentation: 'DELETE');

  final String parameterRepresentation;

  const RESTMethodTypes({required this.parameterRepresentation});
}

class ApiException extends DioException {
  ApiException({required super.requestOptions, this.errMessage, this.title, this.statusCode});

  factory ApiException.detailed({
    /// Parameters sent to server
    required Map<String, dynamic>? parameters,

    /// Endpoint
    required String endpoint,

    /// Response from server
    required Map<String, dynamic>? response,

    /// Status code of response
    required int? statusCode,
    RequestOptions? requestOptions,
  }) {
    return ApiException(
      requestOptions: requestOptions!,
      errMessage:
          response == null
              ? null
              : response.containsKey('detail')
              ? response['detail']
              : null,
      title:
          response == null
              ? null
              : response.containsKey('title')
              ? response['title']
              : null,
      statusCode: statusCode,
    );
  }
  final String? errMessage;
  final String? title;
  final num? statusCode;
}
