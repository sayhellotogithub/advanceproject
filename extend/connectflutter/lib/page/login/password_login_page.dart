// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/component/index.dart';
import 'package:connectflutter/component/title/index.dart';
import 'package:connectflutter/l10n/index.dart';
import 'package:connectflutter/native_link/verify_dialog.dart';
import 'package:connectflutter/net/api_service_provider.dart';
import 'package:connectflutter/provider/app_state_manager_provier.dart';
import 'package:connectflutter/route/app_router_provider.dart';
import 'package:connectflutter/share_pref/token_share_pref.dart';
import 'package:connectflutter/theme/theme_util.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../model/index.dart';

class PasswordLoginPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<PasswordLoginPage> createState() {
    return _PasswordLoginPageState();
  }
}

class _PasswordLoginPageState extends ConsumerState<PasswordLoginPage> {
  String? _phoneNumber;
  CityModel? cityModel;
  String? token;
  String? password;
  VerificationDialog verificationDialog = VerificationDialog();
  CancelFunc? showToastFunc;

  void handlerPhoneNumberChange(String number) {
    setState(() {
      _phoneNumber = number;
    });
  }

  void handleItemClick(CityModel cityModel) {
    this.cityModel = cityModel;
    setState(() {});
  }

  void passwordChange(String password) {
    setState(() {
      this.password = password;
    });
  }

  bool isActive() {
    return (RegexUtil.isNumber(_phoneNumber) ||
            RegexUtil.isEmail(_phoneNumber)) &&
        !TextUtil.isEmpty(this.password);
  }

  void getToken(String token) {
    this.token = token;
    if (!TextUtil.isEmpty(token)) {
      login();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageUtil.buildPage(
      _buildBody(),
      TitleWidget(
        rightTitle: AppLocalizations.of(context)!.auth_code_login,
        rightClick: () {
          ref.read(appStateManagerProvider.notifier).loginSuccess();
          context.go(homePath);
        },
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: DimenUtil.width20,
            top: DimenUtil.height20,
            right: DimenUtil.width20,
          ),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.password_login,
                style: TextStyle(
                  color: Color(0xff303030),
                  fontSize: FontSizeUtil.size24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: DimenUtil.height60),
              EmailOrPhoneWidget(
                textChanged: handlerPhoneNumberChange,
                itemClick: handleItemClick,
              ),
              SizedBox(height: DimenUtil.height10),
              CommonInputFieldWidget(
                hintText: AppLocalizations.of(context)!.please_fill_password,
                textChanged: passwordChange,
                obscureText: true,
              ),
              SizedBox(height: DimenUtil.height20),
              CommonButtonWidget(
                enable: isActive(),
                buttonText: AppLocalizations.of(context)!.login,
                buttonClick: () {
                  // verificationDialog.getToken(getToken);
                  login();
                },
              ),
              SizedBox(height: DimenUtil.height20),
              InkWell(
                onTap: () {
                  context.go(forgetPasswordPath);
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    AppLocalizations.of(context)!.forget_password,
                    style: ThemeUtil.textUnlineStyle(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(child: LoginBottomWidget(), bottom: DimenUtil.height60),
      ],
    );
  }

  void login() {
    final body = LoginRequestBodyModel(
      loginType: RegexUtil.isNumber(_phoneNumber) ? "phone" : "email",
      loginName: _phoneNumber ?? "",
      password: password ?? "",
      token: token ?? "",
    );
    final response = ref.read(loginProvider(body).future);
    response
        .then((result) {
          if (result.success == true) {
            TokenSharePref.saveRefreshToken(result.data?.refreshToken ?? "");
            TokenSharePref.saveUserToken(result.data?.userToken ?? "");
            context.go(homePath);
          } else {
            showToastFunc?.call();
            showToastFunc = ToastUtil.showText(result.msg ?? "");
            //todo
            // if (result.code.toString() == BusinessErrorCode.NEED_THRID_VER) {
            //   verificationDialog.getToken(getToken);
            // }
          }
        })
        .onError((error, stackTrace) {});
  }
}
