// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';

class LoginBottomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(
        width: 20,
      ),
      Text(
        "注册/登录即表示您已阅读并同意",
        style: TextStyle(fontSize: 12, color: ColorUtil.colorFFB6B6B6),
      ),
      Text(
        "《用户协议》",
        style: TextStyle(fontSize: 12, color: ColorUtil.colorFF445FF1),
      )
    ]);
  }
}
