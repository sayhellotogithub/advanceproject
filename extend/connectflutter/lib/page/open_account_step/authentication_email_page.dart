// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/page/base/base_state.dart';
import 'package:connectflutter/component/index.dart';
import 'package:connectflutter/component/title/common_title_widget.dart';
import 'package:connectflutter/l10n/index.dart';
import 'package:connectflutter/route/app_router_provider.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../component/linear_percent_indicator.dart';

class AuthenticationEmailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthenticatioEmailPageState();
  }
}

class _AuthenticatioEmailPageState extends BaseState<AuthenticationEmailPage> {
  @override
  Widget build(BuildContext context) {
    return PageUtil.buildPage(
        _buildBody(),
        CommonTitleWidget(
          title: AppLocalizations.of(context)!.authen_email,
        ));
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.only(
        left: DimenUtil.width20,
        right:DimenUtil.width20,
      ),
      color: Colors.white,
      child: Stack(
        children: [
          _buildTopBody(),
          Positioned(
            child: _buildBottomButton(),
            left: 0,
            right: 0,
            bottom: 0,
          )
        ],
      ),
    );
  }

  Widget _buildTopBody() {
    return ListView(
      children: [
        LinearPercentIndicator(
          lineHeight: 10,
          percent: 0.2,
          padding: EdgeInsets.zero,
          progressColor: ColorUtil.colorFFF1DD44,
          backgroundColor: ColorUtil.colorFFF7F7F7,
        ),
        SizedBox(
          height: DimenUtil.height20,
        ),
        EmailOrPhoneWidget(
          showPrefix: true,
        ),
        SizedBox(
          height:DimenUtil.height10,
        ),
        Row(
          children: [
            Expanded(
              child: CommonInputFieldWidget(
                hintText: AppLocalizations.of(context)!.sms_code,
              ),
            ),
            SizedBox(
              width: DimenUtil.width10,
            ),
            CommonButtonWidget(
                buttonText: AppLocalizations.of(context)!.get_auth_code,
                width: DimenUtil.width145,
                enable: false),
          ],
        ),
        SizedBox(
          height: DimenUtil.height10,
        ),
        Text(
          AppLocalizations.of(context)!.authentication_phone_warm_tip,
          style: TextStyle(fontSize: FontSizeUtil.size12, color: ColorUtil.colorFF828282),
        )
      ],
    );
  }

  Widget _buildBottomButton() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: DimenUtil.width20,
        top: DimenUtil.height10,
        right:DimenUtil.width20,
        bottom: DimenUtil.pageBottom,
      ),
      child: CommonButtonWidget(
        buttonText:
            AppLocalizations.of(context)!.next_step_authentication_email,
        enable: true,
        buttonClick: () {
          context.push(uploadBankPath);
        },
      ),
    );
  }
}
