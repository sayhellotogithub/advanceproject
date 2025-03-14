// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_code_requestbody_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthCodeRequestModel _$AuthCodeRequestModelFromJson(
  Map<String, dynamic> json,
) =>
    AuthCodeRequestModel(
        telephoneCode: json['telephoneCode'] as String?,
        account: json['account'] as String?,
        bizType: json['bizType'] as String?,
        token: json['token'] as String?,
      )
      ..invokerChannel = json['invokerChannel'] as String
      ..invokerDevice = json['invokerDevice'] as String?
      ..corpId = json['corpId'] as String;

Map<String, dynamic> _$AuthCodeRequestModelToJson(
  AuthCodeRequestModel instance,
) => <String, dynamic>{
  'invokerChannel': instance.invokerChannel,
  'invokerDevice': instance.invokerDevice,
  'corpId': instance.corpId,
  'telephoneCode': instance.telephoneCode,
  'account': instance.account,
  'bizType': instance.bizType,
  'token': instance.token,
};
