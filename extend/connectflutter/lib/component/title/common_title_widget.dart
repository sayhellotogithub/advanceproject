// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/component/title/title_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/**
 * back ,title,right
 */
class CommonTitleWidget extends StatefulWidget {
  final String? title;
  final Widget? rightWidget;

  const CommonTitleWidget({Key? key, this.title, this.rightWidget})
      : super(key: key);

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
      color: TitleUitl.BACK_GROUND_WHITE,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TitleUitl.getLeftBackWidget(() {
            context.pop();
          }),
          SizedBox(
            width: 10,
          ),
          if (widget.title != null)
            Expanded(child: TitleUitl.getTitleWidget(widget.title!)),
          if (widget.rightWidget != null) widget.rightWidget!
        ],
      ),
    );
  }
}
