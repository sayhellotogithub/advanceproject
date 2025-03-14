// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/util/toast/custom_loading_widget.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class ToastUtil {
  static CancelFunc showLoading() {
    return BotToast.showCustomLoading(
        toastBuilder: (cancelFunc) {
          return CustomLoadingWidget(
            cancelFunc: cancelFunc,
          );
        },
        clickClose: true,
        allowClick: true,
        crossPage: true,
        backButtonBehavior: BackButtonBehavior.close,
        animationDuration: Duration(milliseconds: 200),
        animationReverseDuration: Duration(milliseconds: 200),
        backgroundColor: Color(0x42000000));
  }

  static CancelFunc showText(String msg) {
    return BotToast.showText(
        text: msg,
        align: Alignment.center,
        animationDuration: Duration(milliseconds: 200),
        animationReverseDuration: Duration(milliseconds: 200),
        textStyle: TextStyle(color: Colors.white, fontSize: 14),
        borderRadius: BorderRadius.circular(9),
        contentPadding: EdgeInsets.only(left: 13, right: 13, top: 8, bottom: 8),
        backgroundColor: Colors.transparent,
        contentColor: Colors.black);
    // BotToast.showText(text: msg);
  }
}
