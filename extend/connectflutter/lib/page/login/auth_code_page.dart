// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'dart:async';

import 'package:connectflutter/component/pincode/models/animation_type.dart';
import 'package:connectflutter/component/pincode/models/pin_theme.dart';
import 'package:connectflutter/component/pincode/pin_code_fields.dart';
import 'package:connectflutter/component/title/index.dart';
import 'package:connectflutter/l10n/index.dart';
import 'package:connectflutter/model/auth_code_requestbody_model.dart';
import 'package:connectflutter/model/login_request_body_model.dart';
import 'package:connectflutter/model/verify_reset_password_body_model.dart';
import 'package:connectflutter/native_link/verify_dialog.dart';
import 'package:connectflutter/net/api_service_provider.dart';
import 'package:connectflutter/route/app_router_provider.dart';
import 'package:connectflutter/share_pref/token_share_pref.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class AuthCodePage extends ConsumerStatefulWidget {
  final String token;
  final String? countryCode;
  final String account;
  final bool isForget;

  AuthCodePage({
    Key? key,
    required this.token,
    required this.account,
    this.countryCode,
    this.isForget = false,
  }) : super(key: key);

  @override
  ConsumerState<AuthCodePage> createState() {
    return _AuthCodePageState();
  }
}

class _AuthCodePageState extends ConsumerState<AuthCodePage> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  final CountdownController countdownController = new CountdownController(
    autoStart: false,
  );

  final totalCount = 5;

  String sendSuccessTip = "";

  VerificationDialog verificationDialog = VerificationDialog();

  CancelFunc? showToastFunc;
  String _token = "";

  @override
  void didChangeDependencies() {
    print("didChangeDependencies");
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _token = widget.token;

    errorController = StreamController<ErrorAnimationType>();
    if (widget.isForget) {
      showOrHideTip(true);
    } else {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        sendSms();
      });
    }
  }

  void showOrHideTip(bool show) {
    setState(() {
      if (show) {
        sendSuccessTip = "验证码已发至 ${widget.account}";
      } else {
        sendSuccessTip = "";
      }
    });
  }

  void onEndCountDown() {}

  @override
  void dispose() {
    showToastFunc?.call();
    errorController!.close();
    textEditingController.dispose();
    verificationDialog.destory();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageUtil.buildPage(buildBody(), buildTitle());
  }

  Widget buildBody() {
    return Container(
      color: Colors.white,
      constraints: BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: DimenUtil.width20,
              top: DimenUtil.height20,
              right: DimenUtil.width20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.fill_auth_code,
                  style: TextStyle(
                    fontSize: FontSizeUtil.size24,
                    color: ColorUtil.color303030,
                  ),
                ),
                SizedBox(height: DimenUtil.height4),
                Text(
                  sendSuccessTip,
                  style: TextStyle(
                    fontSize: FontSizeUtil.size12,
                    color: ColorUtil.colorFF828282,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: DimenUtil.height20),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8),
              child: PinCodeTextField(
                appContext: context,
                backgroundColor: Colors.white,
                pastedTextStyle: TextStyle(
                  color: Colors.transparent,
                  fontWeight: FontWeight.bold,
                  fontSize: FontSizeUtil.size24,
                ),
                length: 6,
                autoFocus: true,
                obscureText: false,
                // obscuringCharacter: '*',
                // obscuringWidget: FlutterLogo(
                //   size: 24,
                // ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                blinkWhenObscuring: true,
                animationType: AnimationType.fade,
                autovalidateMode: AutovalidateMode.disabled,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(DimenUtil.radius16),
                  fieldHeight: DimenUtil.height80,
                  fieldWidth: DimenUtil.width50,
                  inactiveColor: Colors.transparent,
                  inactiveFillColor: ColorUtil.colorFFF6F6F6,
                  selectedColor: Colors.transparent,
                  selectedFillColor: ColorUtil.colorFFF6F6F6,
                  activeColor: Colors.transparent,
                  activeFillColor: ColorUtil.colorFFF6F6F6,
                ),
                cursorColor: ColorUtil.colorFF445FF1,
                animationDuration: Duration(milliseconds: 300),
                enableActiveFill: true,
                errorAnimationController: errorController,
                controller: textEditingController,
                keyboardType: TextInputType.number,
                boxShadows: [
                  // BoxShadow(
                  //   offset: Offset(0, 0),
                  //   color: Colors.black12,
                  //   blurRadius: 10,
                  // )
                ],
                onCompleted: (v) {
                  print("Completed");
                  if (widget.isForget) {
                    verifyResetPassword();
                  } else {
                    login();
                  }
                },
                // onTap: () {
                //   print("Pressed");
                // },
                onChanged: (value) {
                  print(value);
                  // setState(() {
                  //   currentText = value;
                  // });
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              ),
            ),
            margin: EdgeInsets.only(
              left: DimenUtil.width10,
              right: DimenUtil.width10,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: DimenUtil.width20,
              top: DimenUtil.height20,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  verificationDialog.getToken(getToken);
                },
                child: Countdown(
                  controller: countdownController,
                  seconds: totalCount,
                  build: (_, double time) {
                    return Text(
                      isEndTime(time)
                          ? AppLocalizations.of(context)!.resend
                          : "${AppLocalizations.of(context)!.resend}（${time.toInt()}s）",
                      style:
                          isEndTime(time)
                              ? TextStyle(
                                fontSize: FontSizeUtil.size12,
                                color: ColorUtil.colorFF445FF1,
                                decoration: TextDecoration.underline,
                              )
                              : TextStyle(
                                fontSize: FontSizeUtil.size12,
                                color: ColorUtil.colorFF828282,
                                decoration: TextDecoration.underline,
                              ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isEndTime(double time) {
    return time == totalCount || time == 0;
  }

  Widget buildTitle() {
    return CommonTitleWidget();
  }

  void sendSms() async {
    var body = AuthCodeRequestModel(
      account: widget.account,
      telephoneCode: widget.countryCode,
      bizType:
          widget.isForget
              ? AuthCodeRequestModel.RESET_LOGIN_PASSWORD
              : AuthCodeRequestModel.REGISTER_OR_LOGIN,
      token: _token,
    );
    final response = await ref.read(sendAuthCodeProvider(body).future);
    if (response.success == true) {
      showOrHideTip(true);
    } else {
      //send fail
      showToastFunc?.call();
      showToastFunc = ToastUtil.showText(response.msg ?? "");
    }
  }

  void getToken(String token) {
    _token = token;
    if (!TextUtil.isEmpty(token)) {
      sendSms();
      countdownController.restart();
    }
  }

  void verifyResetPassword() async {
    var body = VerifyResetPasswordBodyModel(
      account: widget.account,
      telephoneCode: RegexUtil.handleCountryCode(widget.countryCode),
      verifyCode: textEditingController.text,
    );

    final response = await ref.read(verifyRestPasswordProvider(body).future);
    if (response.success == true) {
      context.go(resetPasswordPath + "/${response.data}/${widget.account}");
    } else {
      showToastFunc?.call();
      showToastFunc = ToastUtil.showText(response.msg ?? "");
    }
  }

  void login() {
    var body = LoginRequestBodyModel(
      loginName: widget.account,
      telephoneCode: RegexUtil.handleCountryCode(widget.countryCode),
      loginType: "1",
      verifyCode: textEditingController.text,
    );
    final response = ref.read(loginProvider(body).future);
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
}
