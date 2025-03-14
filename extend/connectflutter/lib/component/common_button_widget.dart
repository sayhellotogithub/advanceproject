// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/theme/theme_util.dart';
import 'package:flutter/material.dart';

class CommonButtonWidget extends StatefulWidget {
  String buttonText;
  bool enable;
  VoidCallback? buttonClick;
  double height;
  double width;

  CommonButtonWidget(
      {Key? key,
      required this.buttonText,
      required this.enable,
      this.buttonClick,
      this.height = 50,
      this.width = double.infinity})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CommonButtonWidgetState();
  }
}

class _CommonButtonWidgetState extends State<CommonButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 900),
          height: widget.height,
          width: widget.width,
          decoration: widget.enable
              ? ThemeUtil.buttonActiveStyle()
              : ThemeUtil.buttonUnActiveStyle(),
          child: Center(
            child: Text(widget.buttonText,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                )),
          )),
      onTap: () {
        if (widget.enable) widget.buttonClick?.call();
      },
    );
  }
}
