// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/27
// Description:
// -------------------------------------------------------------------
import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_status_bar_page.dart';

class StatusBarConfigurationGuidePage extends StatefulWidget {
  @override
  _StatusBarConfigurationGuideState createState() =>
      _StatusBarConfigurationGuideState();
}

class _StatusBarConfigurationGuideState
    extends State<StatusBarConfigurationGuidePage> {
  // ステータスバーの設定タイプ
  bool _isTransparent = false;
  bool _isDarkMode = false;

  // 動的なステータスバースタイルの変更
  void _toggleStatusBarStyle() {
    setState(() {
      _isTransparent = !_isTransparent;
      _isDarkMode = !_isDarkMode;

      // 動的なスタイル変更
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: _isTransparent ? Colors.transparent : Colors.white,
          statusBarIconBrightness:
              _isDarkMode ? Brightness.light : Brightness.dark,
          statusBarBrightness: _isDarkMode ? Brightness.dark : Brightness.light,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ステータスバー設定ガイド')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ステータスバースタイル切り替えボタン
            ElevatedButton(
              onPressed: _toggleStatusBarStyle,
              child: Text('ステータスバースタイル切り替え'),
            ),
            SizedBox(height: 20),

            // 全画面モード設定ボタン
            ElevatedButton(
              onPressed: StatusBarUtil.configureFullScreenMode,
              child: Text('全画面モード'),
            ),
            SizedBox(height: 20),
            // 全画面モード設定ボタン
            ElevatedButton(
              onPressed: StatusBarUtil.exitFullScreen,
              child: Text('正常モード'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DefaultStatusBarPage(),
                  ),
                );
              },
              child: Text('デフォルトステータスバーページ'),
            ),
            SizedBox(height: 20),

            // カスタムステータスバー
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomStatusBarPage(),
                  ),
                );
              },
              child: Text('カスタムステータスバーページ'),
            ),
            SizedBox(height: 20),

            // 透明ステータスバー
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransparentStatusBarPage(),
                  ),
                );
              },
              child: Text('透明ステータスバーページ'),
            ),

            // 現在のステータスバー状態の表示
            Text(
              ' 透明度: ${_isTransparent ? 'ON' : 'OFF'}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'ダークモード: ${_isDarkMode ? 'ON' : 'OFF'}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // ページを離れる際に必ず通常のUIモードに戻す
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }
}
