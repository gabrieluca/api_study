import 'package:api_study/data/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:api_study/domain/failure.dart';

import '../domain/movie.dart';
import '../domain/movie_response_model.dart';

class MovieController {
  final _repository = Repository();

  MovieResponseModel? movieResponseModel;
  IFailure? movieError;
  bool loading = true;

  List<Movie> get movies => movieResponseModel?.movies ?? <Movie>[];
  int get moviesCount => movies.length;
  bool get hasMovies => moviesCount != 0;
  int get totalPages => movieResponseModel?.totalPages ?? 1;
  int get currentPage => movieResponseModel?.page ?? 1;

  Future<Either<IFailure, MovieResponseModel>> fetchAllMovies(
      {int page = 1}) async {
    movieError = null;
    final result = await _repository.getAllMovies(page);
    result.fold(
      (error) => movieError = error,
      (movie) {
        if (movieResponseModel == null) {
          movieResponseModel = movie;
        } else {
          movieResponseModel?.page = movie.page;
          movieResponseModel?.movies?.addAll(movie.movies!);
        }
      },
    );

    return result;
  }

  Future<Either<IFailure, MovieResponseModel>> searchMovie(
      String searchTerm) async {
    movieError = null;
    final result = await _repository.searchMovie(searchTerm);
    result.fold(
      (error) => movieError = error,
      (movie) {
        movieResponseModel = movie;
      },
    );

    return result;
  }
}
