import 'package:json_annotation/json_annotation.dart';

import 'base_request_model.dart';

part 'reset_password_request_body_model.g.dart';
@JsonSerializable()
class ResetPasswordRequestBodyModel extends BaseRequestModel {
  String? loginPassword;
  String? confirmLoginPassword;
  String? loginName;
  String? bizToken;

  ResetPasswordRequestBodyModel(
      {this.loginPassword,
      this.bizToken,
      this.loginName,
      this.confirmLoginPassword})
      : super();

  factory ResetPasswordRequestBodyModel.fromJson(Map<String, dynamic> map) =>
      _$ResetPasswordRequestBodyModelFromJson(map);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestBodyModelToJson(this);
}
