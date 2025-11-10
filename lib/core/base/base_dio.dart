import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../config/network_connectivity.dart';
import '../../shared_preferences/shared_preferences.dart';
import '../constant/app_constant.dart';
import 'failure.dart';
import 'result.dart';

abstract class IBaseDio {
  Future<Result<T>> request<T>(
    String path, {
    required T Function(Map<String, dynamic> json) fromJson,
    ApiContentType? contentType,
    ApiMethod method = ApiMethod.get,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? part,
    FormData? formData,
  });
}

class BaseDio implements IBaseDio {
  final Dio _dio;

  BaseDio(this._dio);

  void _dismissAllDialog() {
  }

  @override
  Future<Result<T>> request<T>(
    String path, {
    ApiContentType? contentType,
    required T Function(Map<String, dynamic> json) fromJson,
    ApiMethod method = ApiMethod.get,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? part,
    FormData? formData,
  }) async {
    if (await NetworkConnectivity.status) {
      try {
        final response = await _dio.request(path,
            data: formData ?? part,
            options: Options(
              method: method.value,
              contentType: contentType?.value,
            ),
            queryParameters: queryParameters);
        final data = response.data;
        final statusCode = response.statusCode ?? -1;
        return switch (statusCode) {
          >= 200 && < 300 => Result.success(fromJson(data)),
          _ => Result.error(Failure.serverError()),
        };
      } on DioException catch (e) {
        final statusCode = e.response?.statusCode ?? -1;
        switch (statusCode) {
          case HttpConstant.forceUpdate:
            {
              //handle force update
              return Result.error(Failure.forceUpdateError());
            }
          case HttpConstant.maintenance:
            {
              //handle maintenance
              return Result.error(Failure.maintenanceError());
            }
          case HttpConstant.unAuthorization:
            {
              //handle unAuthorization
              _dismissAllDialog();
              GetIt.instance.get<MySharedPreferences>().logout();
              return Result.error(Failure.unAuthorizedError());
            }
          default:
            {
              return Result.error(_convertToFailure(e));
            }
        }
      }
    } else {
      return ResultError(Failure.networkConnection());
    }
  }

  Failure _convertToFailure(DioException error) {
    if (error.response?.data is String) {
      return Failure.error(error.response?.data);
    } else {
      return Failure.error(error.response?.data != null
          ? ((error.response?.data as Map<String, dynamic>?)?["message"] ?? "")
          : "");
    }
  }
}

enum ApiMethod {
  post("POST"),
  put("PUT"),
  delete("DELETE"),
  get("GET");

  const ApiMethod(this.value);
  final String value;
}

enum ApiContentType {
  multipart("multipart/form-data"),
  image("image/*");

  const ApiContentType(this.value);
  final String value;
}
