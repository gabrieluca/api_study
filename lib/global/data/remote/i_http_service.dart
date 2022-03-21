import 'package:dio/dio.dart';

abstract class IHttpService {
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  });

  Future<Response> post(
    String url, {
    Map<String, dynamic>? body,
  });

  Future<Response> put(
    String url, {
    Map<String, dynamic>? body,
  });
  Future<Response> patch(
    String url, {
    Map<String, dynamic>? body,
  });

  Future<Response> delete(
    String url, {
    Map<String, dynamic>? queryParameters,
  });
}
