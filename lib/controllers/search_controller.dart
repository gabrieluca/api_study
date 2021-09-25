import 'package:api_study/data/repository.dart';
import 'package:api_study/domain/failure.dart';
import 'package:api_study/domain/movie.dart';
import 'package:api_study/domain/movie_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class SearchController extends GetxController with StateMixin {
  SearchController();

  final _repository = Repository();

  MovieResponseModel? movieResponseModel;
  IFailure? movieError;
  final showCancel = false.obs;

  List<Movie> get movies => movieResponseModel?.movies ?? <Movie>[];
  int get moviesCount => movies.length;
  bool get hasMovies => moviesCount != 0;
  int get totalPages => movieResponseModel?.totalPages ?? 1;
  int get currentPage => movieResponseModel?.page ?? 1;

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.empty());
  }

  void onFocusChange() {
    showCancel.value = !showCancel.value;
    if (showCancel.value) {
      change(null, status: RxStatus.empty());
    }
  }

  Future<Either<IFailure, MovieResponseModel>> searchMovie(
      String searchTerm) async {
    change(null, status: RxStatus.loading());

    final result = await _repository.searchMovie(searchTerm);
    result.fold(
      (error) => change(null, status: RxStatus.error(error.message)),
      (movie) {
        movieResponseModel = movie;
        change(null, status: RxStatus.success());
      },
    );

    return result;
  }
}

// class SearchController extends GetxController with StateMixin {
//   final _repository = Repository();

//   final movieResponseModel = Rxn<MovieResponseModel>();
//   final lastPage = 1.obs;

//   List<Movie> get movies => movieResponseModel.value?.movies ?? <Movie>[];
//   int get moviesCount => movies.length;
//   bool get hasMovies => moviesCount != 0;
//   int get totalPages => movieResponseModel.value?.totalPages ?? 1;
//   int get currentPage => movieResponseModel.value?.page ?? 1;

//   initController() async {
//     change(null, status: RxStatus.loading());
//     await getAllMovies(lastPage.value);
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     change(null, status: RxStatus.loading());

//     getAllMovies(currentPage);
//   }

//   Future<Either<IFailure, MovieResponseModel>> getAllMovies(
//       [int page = 1]) async {
//     change(null, status: RxStatus.loading());
//     final result = await _repository.getAllMovies(page);
//     result.fold(
//       (error) {
//         change(null, status: RxStatus.error(error.message));
//       },
//       (movie) {
//         if (movieResponseModel.value == null) {
//           movieResponseModel.value = movie;
//         } else {
//           movieResponseModel.value?.page = movie.page;
//           movieResponseModel.value?.movies?.addAll(movie.movies!);
//         }
//         change(null, status: RxStatus.success());
//       },
//     );

//     return result;
//   }
// }
