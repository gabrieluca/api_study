import 'package:api_study/global/data/datasource.dart';
import 'package:api_study/global/data/failure.dart';
import 'package:api_study/global/data/remote/i_http_service.dart';
import 'package:api_study/movie/data/movie_repository.dart';
import 'package:api_study/movies/domain/movie_detail.dart';
import 'package:api_study/movies/domain/movie_response_model.dart';
import 'package:api_study/movies/domain/movie_trailer.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_json.dart';

class MocktIHttpService extends Mock implements IHttpService {}

void main() {
  final httpService = MocktIHttpService();
  final datasource = Datasource(httpService);
  final repository = MovieRepository(datasource);

  const getAllMoviesEndpoint = '/movie/popular?page=1';
  const getMovieEndpoint = '/movie/508947';
  const getTrailerEndpoint = '/movie/508947/videos';
  const searchMovieEndpoint = '/search/movie';
  final requestOptions = RequestOptions(path: '');
  group("getAllMovies", () {
    test(
      'should return a MovieResponseModel on success',
      () async {
        final mockResponse = Response(
          data: allMoviesJson,
          requestOptions: requestOptions,
        );

        when(
          () => httpService.get(getAllMoviesEndpoint),
        ).thenAnswer(
          (_) async => mockResponse,
        );

        final result = await repository.getAllMovies(1);

        verify(() => httpService.get(getAllMoviesEndpoint));
        expect(result.isRight(), true);
        expect(result.fold(id, id), isA<MovieResponseModel>());
      },
    );
    test(
      'should return Failure on wrong data',
      () async {
        final mockResponse = Response(
          data: 'Not found',
          requestOptions: requestOptions,
        );

        when(
          () => httpService.get(getAllMoviesEndpoint),
        ).thenAnswer(
          (_) async => mockResponse,
        );

        final result = await repository.getAllMovies(1);

        verify(() => httpService.get(getAllMoviesEndpoint));
        expect(result.isLeft(), true);
        expect(result.fold(id, id), isA<Failure>());
      },
    );
  });
  group("getMovie", () {
    test(
      'should return a MovieDetail on success',
      () async {
        final mockResponse = Response(
          data: movieJson,
          requestOptions: requestOptions,
        );
        when(
          () => httpService.get(getMovieEndpoint),
        ).thenAnswer(
          (_) async => mockResponse,
        );

        final result = await repository.getMovie(508947);

        verify(() => httpService.get(getMovieEndpoint));
        expect(result.isRight(), true);
        expect(result.fold(id, id), isA<MovieDetail>());
      },
    );
    test(
      'should return Failure on wrong data',
      () async {
        final mockResponse = Response(
          data: 'Not found',
          requestOptions: requestOptions,
        );
        when(
          () => httpService.get(getMovieEndpoint),
        ).thenAnswer(
          (_) async => mockResponse,
        );

        final result = await repository.getMovie(508947);

        verify(() => httpService.get(getMovieEndpoint));
        expect(result.isLeft(), true);
        expect(result.fold(id, id), isA<Failure>());
      },
    );
  });
  group("getMovieTrailer", () {
    test(
      'should return a MovieTrailer on success',
      () async {
        final mockResponse = Response(
          data: trailerJson,
          requestOptions: requestOptions,
        );
        when(
          () => httpService.get(getTrailerEndpoint),
        ).thenAnswer(
          (_) async => mockResponse,
        );

        final result = await repository.getTrailer(508947);

        verify(() => httpService.get(getTrailerEndpoint));
        expect(result.isRight(), true);
        expect(result.fold(id, id), isA<MovieTrailer>());
      },
    );

    test(
      'should return Failure on wrong data',
      () async {
        final mockResponse = Response(
          data: 'Not found',
          requestOptions: requestOptions,
        );
        when(
          () => httpService.get(getTrailerEndpoint),
        ).thenAnswer(
          (_) async => mockResponse,
        );

        final result = await repository.getTrailer(508947);

        verify(() => httpService.get(getTrailerEndpoint));
        expect(result.isLeft(), true);
        expect(result.fold(id, id), isA<Failure>());
      },
    );
  });

  group(
    "searchMovies",
    () {
      test(
        'should return a MovieResponseModel on success',
        () async {
          final mockResponse = Response(
            data: searchJson,
            requestOptions: requestOptions,
          );
          when(
            () => httpService.get(
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
            () => httpService.get(
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
            requestOptions: requestOptions,
          );
          when(
            () => httpService.get(
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
