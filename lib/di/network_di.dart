import 'dart:io';

import 'package:dental_clinic_app/core/extensions/num_extension.dart';
import 'package:dio/dio.dart';
import 'package:dio_intercept_to_curl/dio_intercept_to_curl.dart';
import 'package:get_it/get_it.dart';

import '../config/custom_interceptors.dart';
import '../config/network_config.dart';
import '../core/constant/app_constant.dart';
import '../core/base/base_dio.dart';
import '../shared_preferences/shared_preferences.dart';

class NetworkDi {
  NetworkDi._();

  static Future<void> init(GetIt injector) async {
    GetIt.instance.registerSingletonAsync<NetWorkConfig>(
      () async => await NetWorkConfig.create(),
    );
    GetIt.instance.registerSingleton<CustomInterceptors>(CustomInterceptors());
    await injector.isReady<NetWorkConfig>();
    GetIt.instance.registerSingleton<Dio>(Dio(BaseOptions(
      baseUrl: injector<NetWorkConfig>().baseUrl,
      headers: {
        Headers.contentTypeHeader: Headers.jsonContentType,
        'Authorization': "Bearer ${injector<MySharedPreferences>().user?.accessToken}",
        'device': Platform.isIOS ? DeviceConstants.ios : DeviceConstants.android,
        'version': injector<NetWorkConfig>().version
      },
      connectTimeout: injector<NetWorkConfig>().connectTimeout.seconds,
      receiveTimeout: injector<NetWorkConfig>().receiveTimeout.seconds,
    ))
      ..interceptors.add(injector<CustomInterceptors>())
      ..interceptors.add(DioInterceptToCurl(printOnSuccess: true)));
    GetIt.instance.registerSingleton<IBaseDio>(BaseDio(injector()));
  }
}
