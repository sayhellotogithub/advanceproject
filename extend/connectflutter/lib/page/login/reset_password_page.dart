// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/component/index.dart';
import 'package:connectflutter/component/title/index.dart';
import 'package:connectflutter/l10n/index.dart';
import 'package:connectflutter/model/reset_password_request_body_model.dart';
import 'package:connectflutter/net/api_service_provider.dart';
import 'package:connectflutter/share_pref/token_share_pref.dart';
import 'package:connectflutter/theme/theme_util.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../route/app_router_provider.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  String account;
  String bizToken;

  ResetPasswordPage({Key? key, required this.account, required this.bizToken})
    : super(key: key);

  @override
  ConsumerState<ResetPasswordPage> createState() {
    return _ResetPasswordPageState();
  }
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  String? password;
  String? passwordAgain;
  CancelFunc? showToastFunc;

  @override
  Widget build(BuildContext context) {
    return PageUtil.buildPage(_buildBody(), CommonTitleWidget());
  }

  void passwordChange(String password) {
    setState(() {
      this.password = password;
    });
  }

  void passwordAgainChange(String passwordAgain) {
    setState(() {
      this.passwordAgain = passwordAgain;
    });
  }

  Widget _buildBody() {
    return Container(
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
            AppLocalizations.of(context)!.reset_password,
            style: ThemeUtil.textTitleStyle(),
          ),
          SizedBox(height: DimenUtil.height60),
          CommonInputFieldWidget(
            hintText: AppLocalizations.of(context)!.password_rule_hint,
            textChanged: passwordChange,
            obscureText: true,
          ),
          SizedBox(height: DimenUtil.height10),
          CommonInputFieldWidget(
            hintText: AppLocalizations.of(context)!.please_fill_password_again,
            textChanged: passwordAgainChange,
            obscureText: true,
          ),
          SizedBox(height: DimenUtil.height20),
          CommonButtonWidget(
            enable: isActive(),
            buttonText: AppLocalizations.of(context)!.save,
            buttonClick: () {
              resetPassword();
            },
          ),
        ],
      ),
    );
  }

  void resetPassword() {
    var body = ResetPasswordRequestBodyModel(
      confirmLoginPassword: passwordAgain,
      loginPassword: password,
      bizToken: widget.bizToken,
      loginName: widget.account,
    );
    final response = ref.read(resetPasswordProvider(body).future);
    response.then((result) {
      if (result.success == true) {
        TokenSharePref.saveRefreshToken(result.data?.refreshToken ?? "");
        TokenSharePref.saveUserToken(result.data?.userToken ?? "");
        context.go(homePath);
      } else {
        showToastFunc?.call();
        showToastFunc = ToastUtil.showText(result.msg ?? "");
      }
    });
  }

  bool isActive() {
    return !TextUtil.isEmpty(this.password) ||
        !TextUtil.isEmpty(this.passwordAgain);
  }

  @override
  void dispose() {
    showToastFunc?.call();
    super.dispose();
  }
}
