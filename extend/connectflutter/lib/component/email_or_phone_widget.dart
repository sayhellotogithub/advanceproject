// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/l10n/index.dart';
import 'package:connectflutter/model/city_model.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmailOrPhoneWidget extends StatefulWidget {
  final ValueChanged<String>? textChanged;
  final ValueChanged<CityModel>? itemClick;

  final bool showPrefix;

  String? hintText;

  EmailOrPhoneWidget(
      {Key? key,
      this.textChanged,
      this.itemClick,
      this.showPrefix = false,
      this.hintText})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EmailOrPhoneWidgetState();
  }
}

class _EmailOrPhoneWidgetState extends State<EmailOrPhoneWidget> {
  final _textEditingController = TextEditingController();
  String inputText = "";
  CityModel cityModel = CityModel.defaultModel();

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

  void handleItemClick(CityModel cityModel) {
    widget.itemClick?.call(cityModel);
    setState(() {
      this.cityModel = cityModel;
    });
  }

  void showChooseDialog() {
    DialogUtil.showChooseCountryDialog(context, item: handleItemClick);
  }

  bool showPrefix() {
    if (widget.showPrefix) {
      return widget.showPrefix;
    }
    return RegexUtil.isNumber(inputText);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
          color: Color(0xFFF6F6F6),
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Row(
        children: [
          Visibility(
            visible: showPrefix(),
            // maintainSize: true,
            child: Row(
              children: [
                InkWell(
                  child: Container(
                    width: 45,
                    child: Text(cityModel.telephoneCode ?? "",
                        style: TextStyle(
                          fontSize: 14,
                          color: ColorUtil.color303030,
                        )),
                  ),
                  onTap: () {
                    //请求网络
                    showChooseDialog();
                  },
                ),
                Container(
                  width: 1,
                  height: 24,
                  color: ColorUtil.colorFFDFDFDF,
                ),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
          Flexible(
              child: TextField(
            controller: _textEditingController,
            style: TextStyle(fontSize: 14, color: ColorUtil.color303030),
            decoration: InputDecoration(
              hintText: widget.hintText ??
                  AppLocalizations.of(context)!.please_fill_email_or_phone,
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Color(0xffB6B6B6),
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
