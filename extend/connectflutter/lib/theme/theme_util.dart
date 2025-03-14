// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/util/color_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeUtil {

  static BoxDecoration buttonUnActiveStyle() {
    return BoxDecoration(
        color: Color(0xFFA1AFF8),
        borderRadius: BorderRadius.all(Radius.circular(16.r)));
  }

  static BoxDecoration buttonActiveStyle() {
    return BoxDecoration(
        color: ColorUtil.colorFF445FF1,
        borderRadius: BorderRadius.all(Radius.circular(16.r)));
  }

  static TextStyle textUnlineStyle() {
    return TextStyle(
        fontSize: 12.sp,
        color: ColorUtil.colorFF445FF1,
        decoration: TextDecoration.underline);
  }

  static TextStyle textTitleStyle() {
    return TextStyle(
        color: ColorUtil.color303030,
        fontSize: 24.sp,
        fontWeight: FontWeight.bold);
  }
}
