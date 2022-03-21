import 'package:dartz/dartz.dart';

import 'failure.dart';

abstract class IDatasource {
  Future<Either<Failure, Map<String, dynamic>>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  });

  Future<Either<Failure, Map<String, dynamic>>> post(
    String url, {
    Map<String, dynamic>? body,
  });

  Future<Either<Failure, Map<String, dynamic>>> patch(
    String url, {
    Map<String, dynamic>? body,
  });

  Future<Either<Failure, Map<String, dynamic>>> delete(
    String url, {
    Map<String, dynamic>? queryParameters,
  });

  Future<Either<Failure, Map<String, dynamic>>> put(
    String url, {
    Map<String, dynamic>? body,
  });
}
