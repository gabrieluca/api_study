import 'package:api_study/global/data/datasource.dart';
import 'package:api_study/global/data/failure.dart';
import 'package:api_study/global/data/remote/dio_http_service.dart';
import 'package:api_study/global/data/remote/movie_dio.dart';
import 'package:api_study/movie/data/movie_repository.dart';
import 'package:api_study/movies/domain/movie_detail.dart';
import 'package:api_study/movies/domain/movie_response_model.dart';
import 'package:api_study/movies/domain/movie_trailer.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "Movie Repository from internet",
    () {
      test(
        'should getAllMovies',
        () async {
          final httpService = DioHttpService(MovieDio());
          final datasource = Datasource(httpService);
          final repository = MovieRepository(datasource);

          final result = await repository.getAllMovies(1);

          expect(result.isRight(), true);
          expect(result.fold(id, id), isA<MovieResponseModel>());
        },
      );

      test(
        'should getMovie',
        () async {
          final httpService = DioHttpService(MovieDio());
          final datasource = Datasource(httpService);
          final repository = MovieRepository(datasource);

          final result = await repository.getMovie(508947);

          expect(result.isRight(), true);
          expect(result.fold(id, id), isA<MovieDetail>());
        },
      );
      test(
        'should getTrailer',
        () async {
          final httpService = DioHttpService(MovieDio());
          final datasource = Datasource(httpService);
          final repository = MovieRepository(datasource);

          final result = await repository.getTrailer(508947);

          expect(result.isRight(), true);
          expect(result.fold(id, id), isA<MovieTrailer>());
        },
      );

      test(
        'should searchMovies',
        () async {
          final httpService = DioHttpService(MovieDio());
          final datasource = Datasource(httpService);
          final repository = MovieRepository(datasource);

          final result = await repository.searchMovie('avengers');

          expect(result.isRight(), true);
          expect(result.fold(id, id), isA<MovieResponseModel>());
        },
      );

      test(
        'should return Failure with wrong base url',
        () async {
          final httpService = DioHttpService(Dio());
          final datasource = Datasource(httpService);
          final repository = MovieRepository(datasource);

          final result = await repository.getAllMovies(1);

          expect(result.isLeft(), true);
          expect(result.fold(id, id), isA<Failure>());
        },
      );
    },
  );
}
