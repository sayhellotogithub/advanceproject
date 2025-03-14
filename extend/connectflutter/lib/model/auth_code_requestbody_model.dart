import 'package:connectflutter/model/base_request_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_code_requestbody_model.g.dart';

@JsonSerializable()
class AuthCodeRequestModel extends BaseRequestModel {
  static final REGISTER_OR_LOGIN = "register_or_login";

  static final VERIFY_MOBILE = "verify_mobile";

  static final VERIFY_EMAIL = "verify_email";

  static final RESET_LOGIN_PASSWORD = "reset_login_password";

  String? telephoneCode;
  String? account;
  String?
      bizType; //VERIFY_SIB_MOBILE("verify_sib_mobile","验证SIB手机"), VERIFY_SIB_EMAIL("verify_sib_email","验证SIB邮箱")
  String? token; //顶象token
  AuthCodeRequestModel(
      {this.telephoneCode, this.account, this.bizType, this.token})
      : super();

  factory AuthCodeRequestModel.fromJson(Map<String, dynamic> map) =>
      _$AuthCodeRequestModelFromJson(map);

  Map<String, dynamic> toJson() => _$AuthCodeRequestModelToJson(this);
}
