// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'dart:io';

import 'package:connectflutter/util/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
///解决statusbar color https://stackoverflow.com/questions/52489458/how-to-change-status-bar-color-in-flutter
///
///
class PageUtil {
  static double toolbarHeight = 56.h;

  static Widget buildPage(
    Widget body,
    Widget titleWidget, {
    Color appBarColor = Colors.white,
    Color statusBarColor = Colors.white,
    Brightness statusBarBrightness = Brightness.light,
  }) {
    _setStatusBarColor(statusBarColor, statusBarBrightness);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: toolbarHeight,
        backgroundColor: appBarColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: statusBarColor,
          statusBarIconBrightness: statusBarBrightness,
        ),
        // systemOverlayStyle: SystemUiOverlayStyle.light,
        // ステータスバーの色
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        title: titleWidget,
      ),
      body: SafeArea(child: body),
    );
  }

  static buildLandScapeFullPage(
    Widget body,
    Widget titleWidget, {
    Color statusBarColor = Colors.white,
    Brightness statusBarBrightness = Brightness.light,
  }) {
    _setStatusBarColor(statusBarColor, statusBarBrightness);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: toolbarHeight,
        backgroundColor: ColorUtil.color303030,
        // status bar color
        systemOverlayStyle: SystemUiOverlayStyle.light,
        // ステータスバーの色
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        title: titleWidget,
      ),
      body: SafeArea(child: body),
    );
  }



  // ステータスバーの色を変更（Dart 3.7対応）
  static void _setStatusBarColor(Color color, Brightness brightness) {
    if (Platform.isAndroid || Platform.isIOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: color,
          statusBarIconBrightness: brightness,
        ),
      );
    }
  }
}
