import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/consts/environment/environment.dart';
import 'package:weather_app/mixin/dio_mixin.dart';

class HTTP {
  static Dio _loggerDio(Dio dio) {
    dio.interceptors.addAll(
      <Interceptor>[
        InterceptorsWrapper(
          onRequest:
              (RequestOptions options, RequestInterceptorHandler handler) {
            debugPrint(options.toString());
            return handler.next(options);
          },
          onResponse: (Response options, ResponseInterceptorHandler handler) {
            debugPrint(options.toString());
            return handler.next(options);
          },
          onError: (DioException error, ErrorInterceptorHandler handler) {
            debugPrint(error.toString());
            return handler.next(error);
          },
        ),
      ],
    );
    return dio;
  }

  static Dio get api => CustomDioMixin.dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          options.baseUrl = 'https://api.openweathermap.org/data/2.5';
          // options.baseUrl = Environment.apiKey;
          return handler.next(options);
        },
      ),
    );
}
