// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/27
// Description:
// -------------------------------------------------------------------
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBarUtil {
  const StatusBarUtil._();

  static void setPreferredOrientations() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown,
    ]);
  }

  // 特定のカラーでステータスバーを設定
  static void setStatusBarColor(
    Color color, {
    Brightness iconBrightness = Brightness.dark,
  }) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: color,
        statusBarIconBrightness: iconBrightness,
      ),
    );
  }

  // ステータスバーを透明に設定
  static void setTransparentStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  // プラットフォーム固有のステータスバー設定
  static void applyPlatformSpecificStatusBar(BuildContext context) {
    // 現在のテーマの明るさを取得
    Brightness currentBrightness = MediaQuery.of(context).platformBrightness;
    if (Platform.isIOS) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values, // 上部のみ表示
      );
    }
    if (Platform.isIOS || Platform.isAndroid) {
      if (currentBrightness == Brightness.light) {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
        );
      } else {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.black,
            systemNavigationBarIconBrightness: Brightness.light,
          ),
        );
      }
    }
  }

  static void configureFullScreenMode() {
    if (Platform.isIOS) {
      // iOS用の全画面設定
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [SystemUiOverlay.top], // 上部のみ表示
      );
    } else if (Platform.isAndroid) {
      // Android用の全画面設定
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersive,
        overlays: [], // すべて非表示
      );
    }
  }

  // 通常画面に戻す
  static void exitFullScreen() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values, // すべてのオーバーレイを表示
    );

    // オプション: デフォルトのステータスバースタイルに戻す
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }
}
