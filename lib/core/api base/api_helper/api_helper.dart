import 'package:dio/dio.dart';
import 'package:field_tracker/core/api%20base/api_endpoint/api_endpoints.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../api method/api_method.dart';
import 'api_interceptor.dart';

final getIt = GetIt.instance;

class ApiHelper {
  final Dio dio;
  ApiHelper._internal()
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          connectTimeout: Duration(seconds: 10),
          receiveTimeout: Duration(seconds: 15),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      ) {
    dio.interceptors.add(AuthInterceptor());
    dio.interceptors.add(
      PrettyDioLogger(
        enabled: true,
        requestBody: true,
        error: true,
        responseBody: false,
      ),
    );
  }

  static void setup() {
    getIt.registerLazySingleton(() => ApiHelper._internal());
    getIt.registerLazySingleton(() => ApiMethod(getIt<ApiHelper>().dio));
  }
}
