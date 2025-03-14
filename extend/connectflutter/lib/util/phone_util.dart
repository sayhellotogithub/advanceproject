// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:device_info_plus/device_info_plus.dart';

class PhoneUtil {
  static String? systemModel;
  static String? systemVersion;

  static void initSystem() {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    deviceInfo.androidInfo
        .then((androidInfo) => {systemModel = androidInfo.model});

    deviceInfo.androidInfo
        .then((androidInfo) => {systemVersion = androidInfo.version.release});
  }
}
