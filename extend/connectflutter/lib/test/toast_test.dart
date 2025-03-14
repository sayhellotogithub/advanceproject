// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/util/toast/toast_util.dart';
import 'package:flutter/material.dart';

class ToastTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          child: Text("Click me"),
          onTap: () {
            // ToastUtil.showText("I'm good for you ");
            ToastUtil.showLoading();
          },
        ),
      ),
    );
  }
}
