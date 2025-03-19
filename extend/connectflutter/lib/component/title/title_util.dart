// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:flutter/material.dart';

import '../../util/index.dart';

class TitleUitl {
  static const double TITLE_HEIGHT = 70;
  static const Color BACK_GROUND_WHITE = Colors.transparent;

  static Widget getLeftBackWidget(Function backClick) {
    return InkWell(
      child: Assets.icon.iconBackArrowBlack.svg(
        height: DimenUtil.width24,
        width: DimenUtil.width24,
      ),
      onTap: () {
        backClick();
      },
    );
  }

  static Widget getTitleWidget(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: FontSizeUtil.size14,
        color: ColorUtil.color303030,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static Widget rightWidget(String rightTitle, Function? rightClick) {
    return InkWell(
      onTap: () {
        rightClick?.call();
      },
      child: Text(
        rightTitle,
        style: TextStyle(
          color: Color(0xFF445FF1),
          fontSize: FontSizeUtil.size14,
        ),
      ),
    );
  }

  static Widget getLeftBackWhiteWidget(Function backClick) {
    return InkWell(
      child: Assets.icon.iconBackArrowWhite.svg(
        height: DimenUtil.width24,
        width: DimenUtil.width24,
      ),
      onTap: () {
        backClick();
      },
    );
  }
}
