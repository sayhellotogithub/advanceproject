// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonInputFieldWidget extends StatefulWidget {
  String? hintText;
  ValueChanged<String>? textChanged;
  EdgeInsetsGeometry? padding;
  bool obscureText;

  CommonInputFieldWidget(
      {Key? key,
      this.hintText,
      this.textChanged,
      this.padding,
      this.obscureText = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CommonInputFieldWidget();
  }
}

class _CommonInputFieldWidget extends State<CommonInputFieldWidget> {
  final _textEditingController = TextEditingController();
  String inputText = "";

  @override
  void initState() {
    _textEditingController.addListener(_handleTextInput);
    super.initState();
  }

  void _handleTextInput() {
    widget.textChanged?.call(_textEditingController.text);
    setState(() {
      inputText = _textEditingController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: widget.padding ?? EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
          color: Color(0xFFF6F6F6),
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Row(
        children: [
          Flexible(
              child: TextField(
            controller: _textEditingController,
            obscureText: widget.obscureText,
            style: TextStyle(fontSize: 14, color: ColorUtil.color303030),
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: ColorUtil.colorFFB6B6B6,
                fontSize: 14,
              ),
            ),
          )),
          Visibility(
            child: InkWell(
              child: SvgPicture.asset(
                ImageUtil.getIconString("icon_clear_grey"),
              ),
              onTap: () {
                setState(() {
                  _textEditingController.text = "";
                });
              },
            ),
            visible: inputText.length > 0,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
