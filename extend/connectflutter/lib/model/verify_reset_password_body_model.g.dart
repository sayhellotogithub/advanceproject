// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_reset_password_body_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyResetPasswordBodyModel _$VerifyResetPasswordBodyModelFromJson(
  Map<String, dynamic> json,
) =>
    VerifyResetPasswordBodyModel(
        telephoneCode: json['telephoneCode'] as String?,
        account: json['account'] as String?,
        verifyCode: json['verifyCode'] as String?,
      )
      ..invokerChannel = json['invokerChannel'] as String
      ..invokerDevice = json['invokerDevice'] as String?
      ..corpId = json['corpId'] as String;

Map<String, dynamic> _$VerifyResetPasswordBodyModelToJson(
  VerifyResetPasswordBodyModel instance,
) => <String, dynamic>{
  'invokerChannel': instance.invokerChannel,
  'invokerDevice': instance.invokerDevice,
  'corpId': instance.corpId,
  'telephoneCode': instance.telephoneCode,
  'account': instance.account,
  'verifyCode': instance.verifyCode,
};
