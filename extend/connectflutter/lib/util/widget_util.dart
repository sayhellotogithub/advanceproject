// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/18
// Description:
// -------------------------------------------------------------------
import 'package:connectflutter/model/index.dart';
import 'package:flutter/material.dart';

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
