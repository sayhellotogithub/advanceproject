import 'package:json_annotation/json_annotation.dart';

part "login_response_body_model.g.dart";
@JsonSerializable()
class LoginResponseBodyModel {
  String? _loginName;
  bool? _isRegister;
  String? _userToken;
  String? _refreshToken;

  String? get loginName => _loginName;
  bool? get isRegister => _isRegister;
  String? get userToken => _userToken;
  String? get refreshToken => _refreshToken;

  LoginResponseBodyModel({
      String? loginName,
      bool? isRegister,
      String? userToken,
      String? refreshToken}){
    _loginName = loginName;
    _isRegister = isRegister;
    _userToken = userToken;
    _refreshToken = refreshToken;
}
factory LoginResponseBodyModel.fromJson(Map<String,dynamic> json) =>_$LoginResponseBodyModelFromJson(json);
Map<String,dynamic> toJson() => _$LoginResponseBodyModelToJson(this);

}