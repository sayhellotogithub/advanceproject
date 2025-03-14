import 'package:json_annotation/json_annotation.dart';

import 'base_request_model.dart';

part "login_request_body_model.g.dart";

//{"bizType":"register_or_login","loginName":"wang.jun16@163.com","loginType":"1"
// ,"telephoneCode":"","verifyCode":"498778","corpId":"Tadle","invokerChannel":"android","invokerDevice":"PLK-AL10+6.0"}
 //   {invokerChannel: android, invokerDevice: PLK-AL10+6.0, corpId: Tadle, loginName: wang.jun16@163.com, telephoneCode: null, loginType: 1
//, bizType: register_or_login, password: null, verifyCode: 410912, token: null}
@JsonSerializable()
class LoginRequestBodyModel extends BaseRequestModel {
  String loginName;
  String? telephoneCode;
  String loginType; //登录/注册方式 1无密码 2 密码登录 3微信(暂不支持)
  String bizType;
  String? password;
  String? verifyCode;
  String? token;

  LoginRequestBodyModel(
      {required this.loginName,
      this.telephoneCode,
      required this.loginType,
      this.bizType = "register_or_login",
      this.password,
      this.verifyCode,
      this.token})
      : super();

  factory LoginRequestBodyModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestBodyModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestBodyModelToJson(this);
}
