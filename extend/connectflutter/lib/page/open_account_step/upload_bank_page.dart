// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/component/index.dart';
import 'package:connectflutter/component/title/index.dart';
import 'package:connectflutter/l10n/index.dart';
import 'package:connectflutter/route/app_router_provider.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UploadBankPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UploadBankPageState();
  }
}

class _UploadBankPageState extends State<UploadBankPage> {
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return PageUtil.buildPage(
      _buildBody(),
      CommonTitleWidget(title: AppLocalizations.of(context)!.bank_card_auth),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.only(
        left: DimenUtil.width20,
        right: DimenUtil.width20,
      ),
      child: Stack(
        children: [
          ListView(
            children: [
              LinearPercentIndicator(
                lineHeight: 10,
                percent: 0.5,
                padding: EdgeInsets.zero,
                progressColor: ColorUtil.colorFFF1DD44,
                backgroundColor: ColorUtil.colorFFF7F7F7,
              ),
              SizedBox(height: DimenUtil.height20),
              UploadImageWidget(),
              SizedBox(height: DimenUtil.height20),
              Text(
                AppLocalizations.of(context)!.upload_bank_card_warm_tip,
                style: TextStyle(fontSize: FontSizeUtil.size12, color: ColorUtil.colorFF828282),
              ),
            ],
          ),
          Positioned(
            bottom: DimenUtil.height34,
            left: 0,
            right: 0,
            child: CommonButtonWidget(
              buttonText:
                  AppLocalizations.of(context)!.next_step_person_info_auth,
              buttonClick: () {
                context.push(electronicSignaturePath);
              },
              enable: true,
            ),
          ),
        ],
      ),
    );
  }
}
