import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

const kBaseUrl = 'https://api.themoviedb.org/3';
const kApiKey =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmZmNhYWNjYThjYzIzMWM0YzJkMDc1ZGJhMTZkM2Q2MiIsInN1YiI6IjVmODM4YzJhOTVjMGFmMDAzOTdkZjU3ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.LPPQ2_7C3rBT4BPC4c3F2SShBkgpyFeS4X20k2oEUO4';

class MovieDio extends DioForNative {
  MovieDio() {
    options = BaseOptions(
      baseUrl: kBaseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
      contentType: 'application/json;charset=utf-8',
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmZmNhYWNjYThjYzIzMWM0YzJkMDc1ZGJhMTZkM2Q2MiIsInN1YiI6IjVmODM4YzJhOTVjMGFmMDAzOTdkZjU3ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.LPPQ2_7C3rBT4BPC4c3F2SShBkgpyFeS4X20k2oEUO4'
      },
    );
  }
}
