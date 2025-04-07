// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/07
// Description:
// -------------------------------------------------------------------
import 'package:connectflutter/util/index.dart';
import 'package:flutter/services.dart';

class IconChanger {
  static const _channel = MethodChannel('com.iblogstreet.icon_changer');
  static const defaultIcon = 'Default';
  static const oneIcon = 'IconOne';
  static const twoIcon = 'IconTwo';

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
}
