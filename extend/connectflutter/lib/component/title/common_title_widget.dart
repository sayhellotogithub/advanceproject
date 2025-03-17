// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/component/title/title_util.dart';
import 'package:connectflutter/util/dimen_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// back ,title,right
class CommonTitleWidget extends StatefulWidget {
  final String? title;
  final Widget? rightWidget;
  final Color backGroundColor;

  const CommonTitleWidget({
    Key? key,
    this.title,
    this.rightWidget,
    this.backGroundColor = TitleUitl.BACK_GROUND_WHITE,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CommonTitleWidgetState();
  }
}

class _CommonTitleWidgetState extends State<CommonTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: TitleUitl.TITLE_HEIGHT,
      color: widget.backGroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TitleUitl.getLeftBackWidget(() {
            context.pop();
          }),
          SizedBox(width: DimenUtil.width10),
          if (widget.title != null)
            Expanded(child: TitleUitl.getTitleWidget(widget.title!)),
          if (widget.rightWidget != null) widget.rightWidget!,
        ],
      ),
    );
  }
}
