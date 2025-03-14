// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/l10n/index.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonDialog extends StatefulWidget {
  final String title;
  final String content;
  final VoidCallback? cancelClick;
  final VoidCallback? confirmClick;

  const CommonDialog(
      {Key? key,
      required this.title,
      required this.content,
      this.cancelClick,
      this.confirmClick})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CommonDialogState();
  }
}

class _CommonDialogState extends State<CommonDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      elevation: 0,
      backgroundColor: Colors.white,
      child: contentBox(),
    );
  }

  Widget contentBox() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                widget.title,
                style: TextStyle(fontSize: 18, color: ColorUtil.color303030),
              )),
              InkWell(
                child: SvgPicture.asset(
                    ImageUtil.getIconString("icon_close_black")),
                onTap: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.content,
            style: TextStyle(fontSize: 14, color: ColorUtil.color303030),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                  child: InkWell(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border:
                          Border.all(width: 1, color: ColorUtil.colorFF445FF1),
                      color: Colors.white),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.cancel,
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorUtil.colorFF445FF1,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  widget.cancelClick?.call();
                },
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: InkWell(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: ColorUtil.colorFF445FF1),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.confirm,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  widget.confirmClick?.call();
                },
              )),
            ],
          )
        ],
      ),
    );
  }
}
