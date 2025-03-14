// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/component/title/title_util.dart';
import 'package:connectflutter/util/color_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/**
 * back ,title,right
 */
class CommonTitleWhiteWidget extends StatefulWidget {
  final String? title;
  final Widget? rightWidget;

  const CommonTitleWhiteWidget({Key? key, this.title, this.rightWidget})
    : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CommonTitleWhiteWidgetState();
  }
}

class _CommonTitleWhiteWidgetState extends State<CommonTitleWhiteWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: TitleUitl.TITLE_HEIGHT,
      color: ColorUtil.color303030,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TitleUitl.getLeftBackWhiteWidget(() {
            context.pop();
          }),
          SizedBox(width: 10),
          if (widget.title != null)
            Expanded(child: TitleUitl.getWhiteTitleWidget(widget.title!)),
          if (widget.rightWidget != null) widget.rightWidget!,
        ],
      ),
    );
  }
}
