// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class PhoneUtil {
  static String? systemModel;
  static String? systemVersion;

  static void initSystem() {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isMacOS) {
      deviceInfo.iosInfo.then((iosInfo) {
        systemModel = iosInfo.model ?? 'Unknown iOS Model';
        systemVersion = iosInfo.systemVersion ?? 'Unknown iOS Version';
      });
    } else if (Platform.isAndroid) {
      deviceInfo.androidInfo.then(
        (androidInfo) => {systemModel = androidInfo.model},
      );

      deviceInfo.androidInfo.then(
        (androidInfo) => {systemVersion = androidInfo.version.release},
      );
    }
  }
}
