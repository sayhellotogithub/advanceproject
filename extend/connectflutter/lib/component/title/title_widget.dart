// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/component/title/title_util.dart';
import 'package:connectflutter/util/font_size_util.dart';
import 'package:flutter/material.dart';

import '../../route/app_router_provider.dart';

class TitleWidget extends StatefulWidget {
  String rightTitle;
  Function? rightClick;

  TitleWidget({Key? key, required this.rightTitle, this.rightClick})
    : super(key: key);

  @override
  _TitleWidgetState createState() {
    return _TitleWidgetState();
  }
}

class _TitleWidgetState extends State<TitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: TitleUitl.TITLE_HEIGHT,
      color: TitleUitl.BACK_GROUND_WHITE,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TitleUitl.getLeftBackWidget(() {
            safeGoBack(context);
          }),
          InkWell(
            onTap: () {
              widget.rightClick?.call();
            },
            child: Text(
              widget.rightTitle,
              style: TextStyle(
                color: Color(0xFF445FF1),
                fontSize: FontSizeUtil.size14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
