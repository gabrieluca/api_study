import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:api_study/data/repository.dart';
import 'package:api_study/domain/movie_error.dart';
import 'package:api_study/domain/movie_response_model.dart';

void main() {
  //TODO Unit tests
  final _repository = Repository();

  test('Should get all popular movies', () async {
    final result = await _repository.getAllMovies(1);
    expect(result.isRight(), true);
    expect(result.fold(id, id), isA<MovieResponseModel>());
  });

  test('Should error to get all popular movies', () async {
    final result = await _repository.getAllMovies(1000);
    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<MovieError>());
  });
}
