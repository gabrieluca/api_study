import 'package:api_study/global/data/datasource.dart';
import 'package:api_study/global/data/failure.dart';
import 'package:api_study/global/data/remote/i_http_service.dart';
import 'package:api_study/movie/data/movie_repository.dart';
import 'package:api_study/movies/domain/movie_detail.dart';
import 'package:api_study/movies/domain/movie_response_model.dart';
import 'package:api_study/movies/domain/movie_video.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'local_json.dart';
import 'movie_repository_test.mocks.dart';

@GenerateMocks([IHttpService])
void main() {
  final httpService = MockIHttpService();
  final datasource = Datasource(httpService);
  final repository = MovieRepository(datasource);

  const getAllMoviesEndpoint = '/movie/popular?page=1';
  const getMovieEndpoint = '/movie/508947';
  const getTrailerEndpoint = '/movie/508947/videos';
  const searchMovieEndpoint = '/search/movie';
  group(
    "Movie Repository from Mock",
    () {
      test(
        'should getAllMovies from Mock',
        () async {
          final mockResponse = Response(
            data: allMoviesJson,
            requestOptions: RequestOptions(
              baseUrl: 'https://api.themoviedb.org/3/',
              path: getAllMoviesEndpoint,
              method: 'GET',
            ),
          );

          when(
            httpService.get(getAllMoviesEndpoint),
          ).thenAnswer(
            (_) async => mockResponse,
          );

          final result = await repository.getAllMovies(1);

          verify(httpService.get(getAllMoviesEndpoint));
          expect(result.isRight(), true);
          expect(result.fold(id, id), isA<MovieResponseModel>());
        },
      );
      test(
        'should getMovie',
        () async {
          final mockResponse = Response(
            data: movieJson,
            requestOptions: RequestOptions(
              baseUrl: 'https://api.themoviedb.org/3/',
              path: getMovieEndpoint,
              method: 'GET',
            ),
          );
          when(
            httpService.get(getMovieEndpoint),
          ).thenAnswer(
            (_) async => mockResponse,
          );

          final result = await repository.getMovie(508947);

          verify(httpService.get(getMovieEndpoint));
          expect(result.isRight(), true);
          expect(result.fold(id, id), isA<MovieDetail>());
        },
      );
      test(
        'should getTrailer',
        () async {
          final mockResponse = Response(
            data: trailerJson,
            requestOptions: RequestOptions(
              baseUrl: 'https://api.themoviedb.org/3/',
              path: getTrailerEndpoint,
              method: 'GET',
            ),
          );
          when(
            httpService.get(getTrailerEndpoint),
          ).thenAnswer(
            (_) async => mockResponse,
          );

          final result = await repository.getTrailer(508947);

          verify(httpService.get(getTrailerEndpoint));
          expect(result.isRight(), true);
          expect(result.fold(id, id), isA<MovieVideo>());
        },
      );

      test(
        'should searchMovies',
        () async {
          final mockResponse = Response(
            data: searchJson,
            requestOptions: RequestOptions(
              baseUrl: 'https://api.themoviedb.org/3/',
              path: searchMovieEndpoint,
              method: 'GET',
            ),
          );
          when(
            httpService.get(
              searchMovieEndpoint,
              queryParameters: {
                'query': 'avengers',
              },
            ),
          ).thenAnswer(
            (_) async => mockResponse,
          );

          final result = await repository.searchMovie('avengers');

          verify(
            httpService.get(
              searchMovieEndpoint,
              queryParameters: {'query': 'avengers'},
            ),
          );
          expect(result.isRight(), true);
          expect(result.fold(id, id), isA<MovieResponseModel>());
        },
      );
      test(
        'should return Failure on wrong data',
        () async {
          final mockResponse = Response(
            data: 'Not found',
            requestOptions: RequestOptions(
              baseUrl: 'https://api.themoviedb.org/3/',
              path: searchMovieEndpoint,
              method: 'GET',
            ),
          );
          when(
            httpService.get(
              searchMovieEndpoint,
              queryParameters: {
                'query': 'avengers',
              },
            ),
          ).thenAnswer(
            (_) async => mockResponse,
          );

          final result = await repository.searchMovie('avengers');

          expect(result.isLeft(), true);
          expect(result.fold(id, id), isA<Failure>());
        },
      );
    },
  );
}
