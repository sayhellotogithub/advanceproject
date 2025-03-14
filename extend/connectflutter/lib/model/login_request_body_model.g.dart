// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_body_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequestBodyModel _$LoginRequestBodyModelFromJson(
  Map<String, dynamic> json,
) =>
    LoginRequestBodyModel(
        loginName: json['loginName'] as String,
        telephoneCode: json['telephoneCode'] as String?,
        loginType: json['loginType'] as String,
        bizType: json['bizType'] as String? ?? "register_or_login",
        password: json['password'] as String?,
        verifyCode: json['verifyCode'] as String?,
        token: json['token'] as String?,
      )
      ..invokerChannel = json['invokerChannel'] as String
      ..invokerDevice = json['invokerDevice'] as String?
      ..corpId = json['corpId'] as String;

Map<String, dynamic> _$LoginRequestBodyModelToJson(
  LoginRequestBodyModel instance,
) => <String, dynamic>{
  'invokerChannel': instance.invokerChannel,
  'invokerDevice': instance.invokerDevice,
  'corpId': instance.corpId,
  'loginName': instance.loginName,
  'telephoneCode': instance.telephoneCode,
  'loginType': instance.loginType,
  'bizType': instance.bizType,
  'password': instance.password,
  'verifyCode': instance.verifyCode,
  'token': instance.token,
};
