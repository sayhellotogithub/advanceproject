import 'package:json_annotation/json_annotation.dart';

import 'base_request_model.dart';

part  'verify_reset_password_body_model.g.dart';

@JsonSerializable()
class VerifyResetPasswordBodyModel extends BaseRequestModel{
//  var telephoneCode: String? = null,
//     var account: String? = null,
//     var verifyCode: String? = null
String? telephoneCode;
String? account;
String? verifyCode;

VerifyResetPasswordBodyModel(
    {this.telephoneCode,
      this.account,
      this.verifyCode})
    : super();

factory VerifyResetPasswordBodyModel.fromJson(Map<String, dynamic> map) =>
    _$VerifyResetPasswordBodyModelFromJson(map);

Map<String, dynamic> toJson() => _$VerifyResetPasswordBodyModelToJson(this);
}