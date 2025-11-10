import 'package:json_annotation/json_annotation.dart';

abstract class BaseDataModel {
  T fromJson<T extends BaseDataModel>(Map<String, dynamic> json);
}

class BaseResponse {
  final int? statusCode;
  @JsonKey(name: "message")
  final String? msg;

  const BaseResponse({this.statusCode, this.msg});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
        msg: json['message'] as String?, statusCode: json['code'] as int?);
  }
}

class BaseObjectResponse<R extends BaseDataModel> extends BaseResponse {
  final R? data;

  BaseObjectResponse({super.statusCode, super.msg, this.data});

  factory BaseObjectResponse.fromJson(
    Map<String, dynamic> json,
    R model,
  ) {
    return BaseObjectResponse(
      statusCode: json['code'] != null ? json['code'] as int : null,
      msg: json['message'] != null ? json['message'] as String : null,
      data: json['data'] != null
          ? json['data'] is R
              ? (json['data'] as R)
              : model.fromJson(json['data'])
          : null,
    );
  }
}

class BaseListResponse<R extends BaseDataModel> extends BaseResponse {
  final List<R>? data;
  final int? currentPage;
  final int? totalPage;
  final int? total;

  BaseListResponse(
      {super.statusCode,
      super.msg,
      this.data,
      this.currentPage,
      this.totalPage,
      this.total});

  factory BaseListResponse.fromJson(Map<String, dynamic> json, R model) {
    List<R>? listData;
    if (json['data'] != null) {
      listData = (json['data'] as List<dynamic>)
          .map((e) => model.fromJson<R>(e))
          .toList();
    }
    return BaseListResponse(
      currentPage: json['current_page'] as int?,
      totalPage: json['total_page'] as int?,
      statusCode: json['code'] != null ? json['code'] as int : null,
      msg: json['message'] != null ? json['message'] as String : null,
      data: listData,
      total: json['total'] as int?,
    );
  }
}

