import 'package:json_annotation/json_annotation.dart';
part 'base_response_model.g.dart';
@JsonSerializable(genericArgumentFactories: true)
class BaseResponseModel<T> {
  int? _code;
  String? _msg;
  bool? _success;
  T? _data;

  int? get code => _code;

  String? get msg => _msg;

  bool? get success => _success;

  T? get data => _data;

  BaseResponseModel({int? code, String? msg, bool? success, T? data}) {
    _code = code;
    _msg = msg;
    _success = success;
    _data = data;
  }

  factory BaseResponseModel.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseResponseModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseResponseModelToJson(this, toJsonT);

  // BaseResponseModel.fromJson(dynamic json) {
  //   _code = json["code"];
  //   _msg = json["msg"];
  //   _success = json["success"];
  //   _data = json["data"] as T;
  // }
  //
  // Map<String, dynamic> toJson() {
  //   var map = <String, dynamic>{};
  //   map["code"] = _code;
  //   map["msg"] = _msg;
  //   map["success"] = _success;
  //   map["data"] = _data;
  //   return map;
  // }
}
