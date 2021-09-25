import 'package:dartz/dartz.dart';
import 'package:api_study/data/repository.dart';
import 'package:api_study/domain/failure.dart';

import '../domain/movie_detail.dart';

class MovieDetailController {
  final _repository = Repository();

  MovieDetail? movieDetail;
  IFailure? movieError;

  bool loading = true;

  Future<Either<IFailure, MovieDetail>> fetchMovieById(int id) async {
    final result = await _repository.getMovie(id);
    result.fold(
      (error) => movieError = error,
      (detail) => movieDetail = detail,
    );
    return result;
  }
}
