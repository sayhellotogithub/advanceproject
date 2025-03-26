// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/26
// Description:
// -------------------------------------------------------------------
import 'package:connectflutter/component/title/index.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter/cupertino.dart';

class CupertinoCheckboxExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CupertinoCheckboxExampleState();
  }
}

class _CupertinoCheckboxExampleState extends State<CupertinoCheckboxExample> {
  bool? _isChecked = true;

  @override
  Widget build(BuildContext context) {
    return PageUtil.buildPage(
      _buildBody(),
      CommonTitleWidget(title: "CupertinoCheckbox Example"),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1.5,
            child: CupertinoCheckbox(
              value: _isChecked,
              tristate: true,
              onChanged: (value) {
                setState(() {
                  _isChecked = value;
                });
              },
            ),
          ),

          Text('同意しますか？', style: TextStyle(fontSize: FontSizeUtil.size18)),
        ],
      ),
    );
  }
}
