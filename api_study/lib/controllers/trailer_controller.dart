import 'package:api_study/data/repository.dart';
import 'package:api_study/domain/movie_video.dart';
import 'package:getxfire/getxfire.dart';

class TrailerController extends GetxController with StateMixin {
  TrailerController(
    this.movieId,
  );
  final int movieId;
  final _repository = Repository();

  final videoUrl = Rxn<String>();
  final videoModel = Rxn<MovieVideo>();

  String get trailerUrl => videoModel.value!.results.first.key;

  @override
  void onInit() {
    // TODO: implement onInit
    change(null, status: RxStatus.loading());
    getTrailer(movieId);
    super.onInit();
  }

  Future<void> getTrailer(int id) async {
    final result = await _repository.getTrailer(id);
    result.fold(
      (error) {
        change(null, status: RxStatus.error());
        print(error.toString());
      },
      (videoResponse) {
        change(null, status: RxStatus.success());
        videoModel.value = videoResponse;
      },
    );
    change(null, status: RxStatus.success());
  }
}

// class TrailerzController extends GetxController {
//   final _repository = Repository();

//   Video? video;
//   MovieError? movieError;

//   bool loading = true;

//   Future<Either<MovieError, Video>> fetchMovieById(int id) async {
//     final result = await _repository.getTrailer(id);
//     result.fold(
//       (error) => movieError = error,
//       (videoResponse) => video = videoResponse,
//     );
//     return result;
//   }
//