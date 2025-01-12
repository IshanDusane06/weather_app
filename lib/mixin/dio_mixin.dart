import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
export 'package:dio/dio.dart';

mixin CustomDioMixin {
  static Dio dio() {
    return Dio()
      ..interceptors.addAll(
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
  }
}
