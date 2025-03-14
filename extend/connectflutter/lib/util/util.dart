// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/model/city_model.dart';
import 'package:connectflutter/util/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Util {
  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(seconds: 2),
      ),
    );
  }

  static Widget getSusItem(BuildContext context, String tag,
      {double susHeight = 40}) {
    if (tag == '★') {
      tag = '★ 热门城市';
    }
    return Container(
      height: susHeight.h,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 20.w),
      alignment: Alignment.centerLeft,
      child: Text(
        '$tag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.sp,
          color: ColorUtil.colorFFB6B6B6,
        ),
      ),
    );
  }

  static Widget getListItem(BuildContext context, CityModel model,
      ValueChanged<CityModel>? itemClickCall,
      {double susHeight = 40}) {
    return Column(
      children: [
        InkWell(
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            height: susHeight.h,
            child: Text(model.name,
                style: TextStyle(fontSize: 14.sp, color: ColorUtil.color303030)),
          ),
          onTap: () {
            itemClickCall?.call(model);
            print("${model.name}");
            Navigator.pop(context);
            showSnackBar(context, 'onItemClick : ${model.name}');
          },
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Divider(
            color: ColorUtil.lineColor,
            height: 1.w,
          ),
        )
      ],
    );
  }
}
