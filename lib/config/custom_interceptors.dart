import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../shared_preferences/shared_preferences.dart';

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["Authorization"] =
        "Bearer ${GetIt.I.get<MySharedPreferences>()}";
    debugPrint("token ${options.headers["Authorization"]}");
    debugPrint("REQUEST[${options.method}] => PATH: ${options.path}/${options.queryParameters}/${options.data}");
    if(options.data is FormData){
      debugPrint("REQUEST FORMDATA  ${(options.data as FormData).fields}");
    }
    debugPrint("baseUrl  ${options.baseUrl}");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('RESPONSE[${response.statusCode}] => PATH: ${response.data}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
        'ERROR[${err.error}] => PATH: ${err.response?.realUri.path}');
    return super.onError(err, handler);
  }
}
