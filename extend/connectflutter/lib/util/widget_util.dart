// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/18
// Description:
// -------------------------------------------------------------------
import 'package:connectflutter/model/index.dart';
import 'package:flutter/material.dart';

import 'dimen_util.dart';
import 'font_size_util.dart';
import 'url_util.dart';

getWidgetText(String message) {
  return Text(
    message,
    style: TextStyle(
      fontSize: FontSizeUtil.size20,
      fontWeight: FontWeight.bold,
    ),
  );
}

getLinkText(LinkModel link) {
  return GestureDetector(
    onTap: () => openWebPage(Uri.parse(link.url)),
    child: Text(
      link.title,
      style: TextStyle(
        color: Colors.blue,
        decoration: TextDecoration.underline,
      ),
    ),
  );
}

Widget buildWidgetButton(String text, VoidCallback onClick) {
  return InkWell(
    onTap: onClick,
    child: Container(
      padding: EdgeInsets.all(DimenUtil.width10),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: FontSizeUtil.size14),
      ),
    ),
  );
}
