// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/component/dialog/index.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';

class DialogTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          child: Text("Click me"),
          onTap: () {
            DialogUtil.showWarmTipDialog(context);
          },
        ),
      ),
    );
  }
}
