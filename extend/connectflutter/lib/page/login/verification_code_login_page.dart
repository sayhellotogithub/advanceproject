// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/component/index.dart';
import 'package:connectflutter/component/title/title_widget.dart';
import 'package:connectflutter/l10n/index.dart';
import 'package:connectflutter/model/city_model.dart';
import 'package:connectflutter/native_link/verify_dialog.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../route/app_router_provider.dart';

class VerificationCodeLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VerificationCodeLoginPageState();
  }
}

class _VerificationCodeLoginPageState extends State<VerificationCodeLoginPage> {
  String? _phoneNumber;
  CityModel? cityModel;
  String? token;
  VerificationDialog verificationDialog = VerificationDialog();

  void handlerPhoneNumberChange(String number) {
    setState(() {
      _phoneNumber = number;
    });
  }

  void handleItemClick(CityModel cityModel) {
    this.cityModel = cityModel;
    setState(() {});
  }

  void getToken(String token) {
    this.token = token;
    if (!TextUtil.isEmpty(token)) {
      context.go(
        authCodePath +
            "/${token}/${_phoneNumber ?? ""}/${cityModel?.telephoneCode}",
      );
    }
  }

  bool isActive() {
    return RegexUtil.isNumber(_phoneNumber) || RegexUtil.isEmail(_phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return PageUtil.buildPage(
      _buildBody(),
      TitleWidget(
        rightTitle: AppLocalizations.of(context)!.password_login,
        rightClick: () {
          context.go(passwordLoginPath);
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
            top:  DimenUtil.height20,
            right: DimenUtil.width20,
          ),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.auth_code_login,
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
              SizedBox(height: DimenUtil.height20),
              CommonButtonWidget(
                enable: isActive(),
                buttonText: AppLocalizations.of(context)!.register_or_login,
                buttonClick: () {
                  verificationDialog.getToken(getToken);
                },
              ),
            ],
          ),
        ),
        Positioned(child: LoginBottomWidget(), bottom: DimenUtil.height60),
      ],
    );
  }

  @override
  void dispose() {
    verificationDialog.destory();
    super.dispose();
  }
}
