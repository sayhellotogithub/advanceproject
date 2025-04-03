// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';

class CommonInputFieldWidget extends StatefulWidget {
  final String? hintText;
  final ValueChanged<String>? textChanged;
  final EdgeInsetsGeometry? padding;
  final bool obscureText;
  final TextEditingController? controller;

  CommonInputFieldWidget({
    super.key,
    this.hintText,
    this.textChanged,
    this.padding,
    this.obscureText = false,
    this.controller,
  });

  @override
  State<StatefulWidget> createState() {
    return _CommonInputFieldWidget();
  }
}

class _CommonInputFieldWidget extends State<CommonInputFieldWidget> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = widget.controller ?? TextEditingController();
    _textEditingController.addListener(_handleTextInput);
    super.initState();
  }

  void _handleTextInput() {
    widget.textChanged?.call(_textEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Color(0xFFF6F6F6),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
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
            ),
          ),
          if (_textEditingController.text.isNotEmpty)
            InkWell(
              child: Assets.icon.iconClearGrey.svg(),
              onTap: () {
                setState(() {
                  _textEditingController.clear();
                });
              },
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_handleTextInput);
    _textEditingController.dispose();

    super.dispose();
  }
}
