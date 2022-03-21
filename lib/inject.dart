import 'package:api_study/global/data/datasource.dart';
import 'package:api_study/global/data/i_datasource.dart';
import 'package:api_study/movie/data/movie_repository.dart';
import 'package:api_study/movie/domain/i_movie_repository.dart';
import 'package:get_it/get_it.dart';

import 'global/data/remote/dio_http_service.dart';
import 'global/data/remote/i_http_service.dart';

class Inject {
  static void init() {
    final getIt = GetIt.instance;

    getIt.registerLazySingleton<IHttpService>(
      () => DioHttpService(),
    );
    getIt.registerLazySingleton<IDatasource>(
      () => Datasource(getIt()),
    );
    getIt.registerLazySingleton<IMovieRepository>(
      () => MovieRepository(getIt()),
    );
  }
}
