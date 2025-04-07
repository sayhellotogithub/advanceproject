// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/07
// Description:
// -------------------------------------------------------------------

import 'dart:io';

import 'package:flutter/material.dart';

import '../../native_link/icon_changer.dart';
import '../../util/index.dart';

class ChangeIconPage extends StatefulWidget {
  const ChangeIconPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChangeIconPageState();
  }
}

class _ChangeIconPageState extends State<ChangeIconPage> {
  String _currentIcon = 'default';

  @override
  void initState() {
    super.initState();
    // 起動時に現在のアイコンを取得
    if (Platform.isIOS) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final currentIcon = await IconChanger.getCurrentIcon();
        setState(() {
          _currentIcon = currentIcon;
        });
      });
    }
  }

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
          Text('現在のアイコン: $_currentIcon', style: const TextStyle(fontSize: 18)),
          SizedBox(height: DimenUtil.height10),
          buildWidgetButton("アイコン1に変更", () async {
            final result = await IconChanger.changeIcon(IconChanger.oneIcon);
            if (result) {
              ToastUtil.showText("アイコン1に変更成功");
              setState(() {
                _currentIcon = IconChanger.oneIcon;
              });
            } else {
              AppLogger().debug("アイコン1に変更失敗");
            }
          }),
          SizedBox(height: DimenUtil.height10),
          buildWidgetButton("アイコン2に変更", () async {
            final result = await IconChanger.changeIcon(IconChanger.twoIcon);
            if (result) {
              ToastUtil.showText("アイコン2に変更成功");
              setState(() {
                _currentIcon = IconChanger.twoIcon;
              });
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
              setState(() {
                _currentIcon = IconChanger.defaultIcon;
              });
              ToastUtil.showText("Defaultに変更成功");
            } else {
              AppLogger().debug("Defaultに変更失敗");
            }
          }),
          SizedBox(height: DimenUtil.height10),
          Text(
            Platform.isIOS
                ? 'iOSではホーム画面に戻るとアイコンの変更が確認できます'
                : 'Androidではランチャーの再起動が必要な場合があります',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
