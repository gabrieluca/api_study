import 'package:api_study/global/data/i_datasource.dart';
import 'package:api_study/movies/domain/movie_trailer.dart';
import 'package:api_study/movies/domain/movie_response_model.dart';
import 'package:api_study/movies/domain/movie_detail.dart';
import 'package:dartz/dartz.dart';

import '../../global/data/failure.dart';
import '../domain/i_movie_repository.dart';

class MovieRepository extends IMovieRepository {
  final IDatasource datasource;

  MovieRepository(this.datasource);

  @override
  Future<Either<Failure, MovieResponseModel>> getAllMovies(int page) async {
    final responseOrFailure = await datasource.get('/movie/popular?page=$page');

    return responseOrFailure.fold(
      (error) => left(error),
      (success) => Right(MovieResponseModel.fromMap(success)),
    );
  }

  @override
  Future<Either<Failure, MovieDetail>> getMovie(int id) async {
    final responseOrFailure = await datasource.get('/movie/$id');

    return responseOrFailure.fold(
      (error) => left(error),
      (success) => Right(MovieDetail.fromMap(success)),
    );
  }

  @override
  Future<Either<Failure, MovieTrailer>> getTrailer(int id) async {
    final responseOrFailure = await datasource.get('/movie/$id/videos');

    return responseOrFailure.fold(
      (error) => left(error),
      (success) => Right(MovieTrailer.fromMap(success)),
    );
  }

  @override
  Future<Either<Failure, MovieResponseModel>> searchMovie(
      String searchTerm) async {
    final responseOrFailure = await datasource.get(
      '/search/movie',
      queryParameters: {
        'query': searchTerm,
      },
    );

    return responseOrFailure.fold(
      (error) => left(error),
      (success) => Right(MovieResponseModel.fromMap(success)),
    );
  }
}
