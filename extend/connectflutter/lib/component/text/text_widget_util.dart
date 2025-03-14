// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/util/index.dart';
import 'package:flutter/cupertino.dart';

class TextWidgetUtil {
  static Text textTitle(String desc) {
    return Text(
      desc,
      style: TextStyle(
          fontSize: FontSizeUtil.size16, color: ColorUtil.color303030),
    );
  }

  static Text textContent(String desc) {
    return Text(
      desc,
      style: TextStyle(
          fontSize: FontSizeUtil.size14, color: ColorUtil.colorFF828282),
    );
  }
}
