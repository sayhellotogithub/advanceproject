// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/07
// Description:
// -------------------------------------------------------------------

import 'package:flutter/material.dart';

import '../../native_link/icon_changer.dart';
import '../../util/index.dart';

class ChangeIconPage extends StatelessWidget {
  const ChangeIconPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageUtil.buildPage(_buildBody(), Text('Change App Icon'));
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.all(DimenUtil.width20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: DimenUtil.height10),
          buildWidgetButton("アイコン1に変更", () async {
            final result = await IconChanger.changeIcon(IconChanger.oneIcon);
            if (result) {
              ToastUtil.showText("アイコン1に変更成功");
            } else {
              AppLogger().debug("アイコン1に変更失敗");
            }
          }),
          SizedBox(height: DimenUtil.height10),
          buildWidgetButton("アイコン2に変更", () async {
            final result = await IconChanger.changeIcon(IconChanger.twoIcon);
            if (result) {
              ToastUtil.showText("アイコン2に変更成功");
            } else {
              AppLogger().debug("アイコン2に変更失敗");
            }
          }),
          SizedBox(height: DimenUtil.height10),
          buildWidgetButton("Defaultに変更", () async {
            final result = await IconChanger.changeIcon(
              IconChanger.defaultIcon,
            );
            if (result) {
              ToastUtil.showText("Defaultに変更成功");
            } else {
              AppLogger().debug("Defaultに変更失敗");
            }
          }),
        ],
      ),
    );
  }
}
