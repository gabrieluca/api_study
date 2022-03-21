import 'package:dartz/dartz.dart';

import '../../movies/domain/movie_detail.dart';
import '../../movies/domain/movie_response_model.dart';
import '../../movies/domain/movie_trailer.dart';
import '../../global/data/failure.dart';

abstract class IMovieRepository {
  Future<Either<Failure, MovieResponseModel>> getAllMovies(int page);

  Future<Either<Failure, MovieResponseModel>> searchMovie(
    String searchTerm,
  );

  Future<Either<Failure, MovieDetail>> getMovie(int id);

  Future<Either<Failure, MovieTrailer>> getTrailer(int id);
}
