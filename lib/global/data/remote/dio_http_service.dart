import 'dart:convert';

import 'package:api_study/global/data/remote/movie_dio.dart';
import 'package:dio/dio.dart';

import 'i_http_service.dart';

class DioHttpService extends IHttpService {
  late final Dio _dio;

  DioHttpService([Dio? _newDio]) {
    _dio = _newDio ?? MovieDio();
  }

  @override
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.get(url, queryParameters: queryParameters);
  }

  @override
  Future<Response> post(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    return _dio.post(
      url,
      data: jsonEncode(body),
    );
  }

  @override
  Future<Response> patch(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    return _dio.patch(
      url,
      data: jsonEncode(body),
    );
  }

  @override
  Future<Response> delete(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.delete(url, queryParameters: queryParameters);
  }

  @override
  Future<Response> put(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    return _dio.put(
      url,
      data: jsonEncode(body),
    );
  }
}
