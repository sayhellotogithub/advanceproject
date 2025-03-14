// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/component/index.dart';
import 'package:connectflutter/component/title/index.dart';
import 'package:connectflutter/l10n/index.dart';
import 'package:connectflutter/model/auth_code_requestbody_model.dart';
import 'package:connectflutter/model/city_model.dart';
import 'package:connectflutter/native_link/verify_dialog.dart';
import 'package:connectflutter/net/api_service_provider.dart';
import 'package:connectflutter/route/app_router_provider.dart';
import 'package:connectflutter/theme/theme_util.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordMainPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ForgetPasswordMainPage> createState() {
    return _ForgetPasswordMainPageState();
  }
}

class _ForgetPasswordMainPageState
    extends ConsumerState<ForgetPasswordMainPage> {
  String? _phoneNumber;
  CityModel? cityModel;
  String? token;
  VerificationDialog verificationDialog = VerificationDialog();
  CancelFunc? showToastFunc;

  @override
  void initState() {
    cityModel = CityModel.defaultModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageUtil.buildPage(_buildBody(), CommonTitleWidget());
  }

  void handlerPhoneNumberChange(String number) {
    setState(() {
      _phoneNumber = number;
    });
  }

  void handleItemClick(CityModel cityModel) {
    this.cityModel = cityModel;
    print(cityModel);
  }

  void getToken(String token) {
    this.token = token;
    if (!TextUtil.isEmpty(token)) {
      sendSms();
    }
  }

  void sendSms() async {
    showToastFunc = ToastUtil.showLoading();
    var body = AuthCodeRequestModel(
      account: _phoneNumber,
      telephoneCode: cityModel?.telephoneCode,
      bizType: AuthCodeRequestModel.RESET_LOGIN_PASSWORD,
      token: token,
    );
    await ref.read(sendAuthCodeProvider(body).future).then((result) {
      showToastFunc?.call();
      if (result.success == true) {
        context.go(
          authCodePath + "/${_phoneNumber}/${cityModel?.telephoneCode}//true",
        );
      } else {
        showToastFunc?.call();
        showToastFunc = ToastUtil.showText(result.msg ?? "");
      }
    });
  }

  bool isActive() {
    return RegexUtil.isNumber(_phoneNumber) || RegexUtil.isEmail(_phoneNumber);
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
            AppLocalizations.of(context)!.find_password,
            style: ThemeUtil.textTitleStyle(),
          ),
          SizedBox(height: DimenUtil.height60),
          EmailOrPhoneWidget(
            textChanged: handlerPhoneNumberChange,
            itemClick: handleItemClick,
          ),
          SizedBox(height: DimenUtil.height20),
          CommonButtonWidget(
            enable: isActive(),
            buttonText: AppLocalizations.of(context)!.get_auth_code,
            buttonClick: () {
              verificationDialog.getToken(getToken);
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    showToastFunc?.call();
    verificationDialog.destory();
    super.dispose();
  }
}
