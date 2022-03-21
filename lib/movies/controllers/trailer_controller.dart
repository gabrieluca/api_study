import 'package:get/get.dart';

import '../../movie/domain/i_movie_repository.dart';
import '../domain/movie_trailer.dart';

class TrailerController extends GetxController with StateMixin {
  TrailerController(
    this._repository,
    this.movieId,
  );
  final IMovieRepository _repository;
  final int movieId;

  final videoUrl = Rxn<String>();
  final videoModel = Rxn<MovieTrailer>();

  String? get trailerUrl => videoModel.value?.results.first.key;

  @override
  void onInit() {
    change(null, status: RxStatus.loading());
    getTrailer(movieId);
    super.onInit();
  }

  Future<void> getTrailer(int id) async {
    final result = await _repository.getTrailer(id);
    result.fold(
      (error) {
        change(null, status: RxStatus.error());
      },
      (videoResponse) {
        change(null, status: RxStatus.success());
        videoModel.value = videoResponse;
      },
    );
    change(null, status: RxStatus.success());
  }
}
