import 'package:dio/dio.dart';

class DioApi {
  DioApi._();

  static Dio createDio(String _url) {
    var dio = Dio(
      BaseOptions(baseUrl: _url, connectTimeout: 150000),
    );

    return dio;
  }
}
