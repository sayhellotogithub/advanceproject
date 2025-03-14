// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/component/white_board/index.dart';
import 'package:flutter/material.dart';

class WhiteBoardTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WhiteBoardTestState();
  }
}

class WhiteBoardTestState extends State<WhiteBoardTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Whiteboard'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: WhiteBoard(),
            ),
          ],
        ),
      ),
    );
  }
}
