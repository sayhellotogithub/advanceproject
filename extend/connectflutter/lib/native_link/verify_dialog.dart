// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/native_link/native_link.dart';
import 'package:flutter/services.dart';

class VerificationDialog {
  String token = "";

  Future<void> getToken(Function(String token) invoke) async {
    try {
      // final String result =
      //     await NativeLink.verificationChannel.invokeMethod('getCaptchaUtil');
      // print("result$result");
      // token = result;
      invoke.call(token);
    } on PlatformException catch (e) {
      print("Failed to : '${e.message}'.");
    }
  }

  void destory() async {
    // await NativeLink.verificationChannel.invokeMethod('destoryCaptcha');
  }
}
