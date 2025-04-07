// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/07
// Description:
// -------------------------------------------------------------------

import 'dart:io';

import 'package:connectflutter/util/index.dart';
import 'package:flutter/services.dart';

class IconChanger {
  static const _channel = MethodChannel(
    'com.iblogstreet.connectflutter.dynamic_icon/icon',
  );
  static const defaultIcon = 'default';
  static const oneIcon = 'one';
  static const twoIcon = 'two';

  static Future<bool> changeIcon(String aliasName) async {
    try {
      final result = await _channel.invokeMethod('changeIcon', {
        'aliasName': aliasName,
      });
      AppLogger().debug(result);
      return true;
    } on PlatformException catch (e) {
      AppLogger().debug("Failed to change icon: '${e.message}'.");
      return false;
    }
  }

  static Future<String> getCurrentIcon() async {
    if (!Platform.isIOS) return defaultIcon;

    try {
      final String result = await _channel.invokeMethod('getCurrentIcon');
      return result;
    } on PlatformException catch (e) {
      print('アイコン取得エラー: ${e.message}');
      return defaultIcon;
    }
  }
}
