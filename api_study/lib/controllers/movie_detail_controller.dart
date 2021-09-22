import 'package:dartz/dartz.dart';
import 'package:api_study/data/repository.dart';
import 'package:api_study/domain/movie_error.dart';

import '../domain/movie_detail_model.dart';

class MovieDetailController {
  final _repository = Repository();

  MovieDetailModel? movieDetail;
  MovieError? movieError;

  bool loading = true;

  Future<Either<MovieError, MovieDetailModel>> fetchMovieById(int id) async {
    final result = await _repository.getMovie(id);
    result.fold(
      (error) => movieError = error,
      (detail) => movieDetail = detail,
    );
    return result;
  }
}
