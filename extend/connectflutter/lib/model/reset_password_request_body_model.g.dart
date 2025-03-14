// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_request_body_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordRequestBodyModel _$ResetPasswordRequestBodyModelFromJson(
  Map<String, dynamic> json,
) =>
    ResetPasswordRequestBodyModel(
        loginPassword: json['loginPassword'] as String?,
        bizToken: json['bizToken'] as String?,
        loginName: json['loginName'] as String?,
        confirmLoginPassword: json['confirmLoginPassword'] as String?,
      )
      ..invokerChannel = json['invokerChannel'] as String
      ..invokerDevice = json['invokerDevice'] as String?
      ..corpId = json['corpId'] as String;

Map<String, dynamic> _$ResetPasswordRequestBodyModelToJson(
  ResetPasswordRequestBodyModel instance,
) => <String, dynamic>{
  'invokerChannel': instance.invokerChannel,
  'invokerDevice': instance.invokerDevice,
  'corpId': instance.corpId,
  'loginPassword': instance.loginPassword,
  'confirmLoginPassword': instance.confirmLoginPassword,
  'loginName': instance.loginName,
  'bizToken': instance.bizToken,
};
