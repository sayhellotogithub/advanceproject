// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/component/common_button_widget.dart';
import 'package:connectflutter/component/text/text_widget_util.dart';
import 'package:connectflutter/component/title/common_title_widget.dart';
import 'package:connectflutter/l10n/index.dart';
import 'package:connectflutter/route/app_router_provider.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OpenAccountIntroducePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageUtil.buildPage(
      _buildBody(context),
      CommonTitleWidget(
        title: AppLocalizations.of(context)!.open_account_introduction,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        _buildTopBody(context),
        Positioned(
          child: _buildBottomButton(context),
          left: 0,
          right: 0,
          bottom: 0,
        ),
      ],
    );
  }

  Widget _buildTopBody(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: DimenUtil.height10,
            right: DimenUtil.pageRight,
            left: DimenUtil.pageLeft,
            bottom: DimenUtil.height40,
          ),
          child: Image.asset(
            ImageUtil.getImageString("open_account_introduce_logo"),
            height: DimenUtil.height140,
            width: DimenUtil.width156,
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            right: DimenUtil.pageRight,
            top: DimenUtil.height20,
            left: DimenUtil.pageLeft,
            bottom: DimenUtil.height100,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(DimenUtil.radius24),
              topRight: Radius.circular(DimenUtil.radius24),
            ),
            color: ColorUtil.colorFFF6F6F6,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._buildItem(
                AppLocalizations.of(context)!.account_introduction,
                AppLocalizations.of(context)!.account_introduction_desc,
              ),
              ..._buildItem(
                AppLocalizations.of(context)!.account_rights,
                AppLocalizations.of(context)!.account_rights_desc,
              ),
              ..._buildItem(
                AppLocalizations.of(context)!.charging_standard,
                AppLocalizations.of(context)!.charging_standard_desc,
              ),
              ..._buildItem(
                AppLocalizations.of(context)!.application_materials,
                AppLocalizations.of(context)!.application_materials_desc,
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildItem(String title, String desc) {
    var list = <Widget>[
      TextWidgetUtil.textTitle(title),
      SizedBox(height: DimenUtil.height10),
      TextWidgetUtil.textContent(desc),
      SizedBox(height: DimenUtil.height20),
    ];
    return list;
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: DimenUtil.width20,
        top: DimenUtil.height10,
        right: DimenUtil.width20,
        bottom: DimenUtil.pageBottom,
      ),
      child: CommonButtonWidget(
        buttonText: AppLocalizations.of(context)!.i_knows,
        enable: true,
        buttonClick: () {
          context.push(authenticationPhone);
        },
      ),
    );
  }
}
