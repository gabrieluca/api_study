import 'package:api_study/domain/video_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:api_study/domain/movie_error.dart';

import '../core/api_.dart';
import '../domain/movie_detail_model.dart';
import '../domain/movie_response_model.dart';

class Repository {
  final Dio _dio = Dio(kDioOptions);

  Future<Either<MovieError, MovieResponseModel>> getAllMovies(int page) async {
    try {
      final response = await _dio.get('/movie/popular?page=$page');
      final model = MovieResponseModel.fromMap(response.data);
      return Right(model);
    } on DioError catch (error) {
      if (error.response != null) {
        return Left(RepositoryError(error.response!.data['status_message']));
      } else {
        return Left(RepositoryError(kServerError));
      }
    } on Exception catch (error) {
      return Left(RepositoryError(error.toString()));
    }
  }

  Future<Either<MovieError, MovieDetailModel>> getMovie(int id) async {
    try {
      final response = await _dio.get('/movie/$id');
      final model = MovieDetailModel.fromMap(response.data);
      return Right(model);
    } on DioError catch (error) {
      if (error.response != null) {
        return Left(RepositoryError(error.response?.data['status_message']));
      } else {
        return Left(RepositoryError(kServerError));
      }
    } on Exception catch (error) {
      return Left(RepositoryError(error.toString()));
    }
  }

  Future<Either<MovieError, Video>> getTrailer(int id) async {
    try {
      final response = await _dio.get('/movie/$id/videos');
      final model = Video.fromMap(response.data);
      return Right(model);
    } on DioError catch (error) {
      if (error.response != null) {
        return Left(RepositoryError(error.response?.data['status_message']));
      } else {
        return Left(RepositoryError(kServerError));
      }
    } on Exception catch (error) {
      return Left(RepositoryError(error.toString()));
    }
  }
}
// 'https://www.youtube.com/watch?v=$video.results.key'