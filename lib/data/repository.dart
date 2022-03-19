import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../core/constants.dart';
import '../domain/failure.dart';
import '../domain/movie_detail.dart';
import '../domain/movie_response_model.dart';
import '../domain/movie_video.dart';

class Repository {
  final Dio _dio = Dio(kDioOptions);

  Future<Either<IFailure, MovieResponseModel>> getAllMovies(int page) async {
    try {
      final response = await _dio.get('/movie/popular?page=$page');
      final model =
          MovieResponseModel.fromMap(response.data as Map<String, dynamic>);
      return Right(model);
    } on DioError catch (error) {
      if (error.response != null) {
        return Left(Failure(error.response!.data['status_message'] as String));
      } else {
        return Left(Failure(kServerError));
      }
    } on Exception catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  Future<Either<IFailure, MovieResponseModel>> searchMovie(
    String searchTerm,
  ) async {
    try {
      final response = await _dio.get(
        '/search/movie',
        queryParameters: {
          'query': searchTerm,
        },
      );
      final model = MovieResponseModel.fromMap(response.data);
      return Right(model);
    } on DioError catch (error) {
      if (error.response != null) {
        return Left(Failure(error.response!.data['status_message']));
      } else {
        return Left(Failure(kServerError));
      }
    } on Exception catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  Future<Either<IFailure, MovieDetail>> getMovie(int id) async {
    try {
      final response = await _dio.get('/movie/$id');
      final model = MovieDetail.fromMap(response.data);
      return Right(model);
    } on DioError catch (error) {
      if (error.response != null) {
        return Left(Failure(error.response?.data['status_message']));
      } else {
        return Left(Failure(kServerError));
      }
    } on Exception catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  Future<Either<IFailure, MovieVideo>> getTrailer(int id) async {
    try {
      final response = await _dio.get('/movie/$id/videos');
      final model = MovieVideo.fromMap(response.data);
      return Right(model);
    } on DioError catch (error) {
      if (error.response != null) {
        return Left(Failure(error.response?.data['status_message']));
      } else {
        return Left(Failure(kServerError));
      }
    } on Exception catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
