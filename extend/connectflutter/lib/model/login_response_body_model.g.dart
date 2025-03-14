// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_body_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseBodyModel _$LoginResponseBodyModelFromJson(
  Map<String, dynamic> json,
) => LoginResponseBodyModel(
  loginName: json['loginName'] as String?,
  isRegister: json['isRegister'] as bool?,
  userToken: json['userToken'] as String?,
  refreshToken: json['refreshToken'] as String?,
);

Map<String, dynamic> _$LoginResponseBodyModelToJson(
  LoginResponseBodyModel instance,
) => <String, dynamic>{
  'loginName': instance.loginName,
  'isRegister': instance.isRegister,
  'userToken': instance.userToken,
  'refreshToken': instance.refreshToken,
};
