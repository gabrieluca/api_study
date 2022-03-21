import 'package:api_study/global/data/failure.dart';
import 'package:api_study/global/data/i_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'remote/i_http_service.dart';

class Datasource extends IDatasource {
  final IHttpService httpService;

  Datasource(this.httpService);

  @override
  Future<Either<Failure, Map<String, dynamic>>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response =
          await httpService.get(url, queryParameters: queryParameters);

      return Right(response.data);
    } on DioError catch (e) {
      return _dioHandler(e);
    } catch (error) {
      return _unexpectedErrorHandler(error);
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> post(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await httpService.post(
        url,
        body: body,
      );

      return Right(response.data);
    } on DioError catch (e) {
      return _dioHandler(e);
    } catch (error) {
      return _unexpectedErrorHandler(error);
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> patch(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await httpService.patch(
        url,
        body: body,
      );

      return Right(response.data);
    } on DioError catch (e) {
      return _dioHandler(e);
    } catch (error) {
      return _unexpectedErrorHandler(error);
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> delete(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response =
          await httpService.delete(url, queryParameters: queryParameters);

      return Right(response.data);
    } on DioError catch (e) {
      return _dioHandler(e);
    } catch (error) {
      return _unexpectedErrorHandler(error);
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> put(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await httpService.put(
        url,
        body: body,
      );

      return Right(response.data);
    } on DioError catch (e) {
      return _dioHandler(e);
    } catch (error) {
      return _unexpectedErrorHandler(error);
    }
  }
}

Either<Failure, Map<String, dynamic>> _unexpectedErrorHandler(Object error) {
  return Left(
    UnexpectedFailure('Request error: ${error.toString()}'),
  );
}

Either<Failure, Map<String, dynamic>> _dioHandler(DioError e) {
  if (e.response?.statusCode == 401) {
    return Left(
      UnauthorizedFailure(),
    );
  }
  if (e.type == DioErrorType.other) {
    return Left(
      NetworkFailure(e.toString()),
    );
  }
  return Left(
    ResponseFailure('Response error: ${e.response?.statusCode}'),
  );
}
