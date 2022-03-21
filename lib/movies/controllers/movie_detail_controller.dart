import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../global/data/failure.dart';
import '../../movie/domain/i_movie_repository.dart';
import '../domain/movie_detail.dart';

class MovieDetailController extends GetxController with StateMixin {
  MovieDetailController(this._repository, this.movieId);

  final int movieId;
  final IMovieRepository _repository;

  final movieDetail = Rxn<MovieDetail>();

  bool loading = true;

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.loading());

    fetchMovieById(movieId);
  }

  Future<Either<Failure, MovieDetail>> fetchMovieById(int id) async {
    final result = await _repository.getMovie(id);
    result.fold(
      (error) => change(null, status: RxStatus.error(error.message)),
      (detail) {
        movieDetail.value = detail;

        change(null, status: RxStatus.success());
      },
    );
    return result;
  }
}
