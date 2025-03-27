// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
///解决statusbar color https://stackoverflow.com/questions/52489458/how-to-change-status-bar-color-in-flutter
///
///
class PageUtil {
  const PageUtil._(); // インスタンス化を防ぐ
  static double toolbarHeight = 56.h;

  static Widget buildPage(
    Widget body,
    Widget? titleWidget, {

    Widget? bottomNavigationBar = null,
  }) {
    // StatusBarUtil.applyPlatformSpecificStatusBar(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: toolbarHeight,
        // ステータスバーの色
        automaticallyImplyLeading: false,
        title: titleWidget,
      ),
      body: SafeArea(child: body),
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  static buildLandScapeFullPage(
    Widget body,
    Widget? titleWidget, {
    Widget? bottomNavigationBar,
  }) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: toolbarHeight,
        backgroundColor: ColorUtil.color303030,
        // ステータスバーの色
        automaticallyImplyLeading: false,
        title: titleWidget,
      ),
      body: SafeArea(child: body),
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  static Widget buildPageWithNoAppBar(
    Widget body, {
    Widget? bottomNavigationBar = null,
  }) {
    // StatusBarUtil.applyPlatformSpecificStatusBar(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // ステータスバーの色
      body: SafeArea(child: body),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
