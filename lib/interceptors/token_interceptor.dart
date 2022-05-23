import 'package:dio/dio.dart';
import 'package:etra_flutter/utils/utils.dart';

class TokenInterceptor extends Interceptor {
  final String token;

  TokenInterceptor({required this.token});

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (isNotNull(token)) {
      options.headers['Authorization'] = 'Bearer ' + token;
    }
    return Future.value(options);
  }
}
