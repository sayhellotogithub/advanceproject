// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/26
// Description:
// -------------------------------------------------------------------
import 'package:connectflutter/component/title/common_title_widget.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter/cupertino.dart';

class CupertinoSwitchExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CupertinoSwitchExampleState();
  }
}

class _CupertinoSwitchExampleState extends State<CupertinoSwitchExample> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return PageUtil.buildPage(
      _buildBody(),
      CommonTitleWidget(title: "CupertinoSwitchExample"),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoSwitch(
            value: _switchValue,
            onChanged: (value) {
              setState(() {
                _switchValue = value;
              });
            },
          ),
          SizedBox(height: DimenUtil.height20),
          CupertinoSwitch(
            value: _switchValue,
            activeTrackColor: CupertinoColors.activeGreen,
            inactiveTrackColor: CupertinoColors.destructiveRed,
            thumbColor: CupertinoColors.activeOrange,
            inactiveThumbColor: CupertinoColors.systemTeal,
            onChanged: (value) {
              setState(() {
                _switchValue = value;
              });
            },
          ),
          SizedBox(height: DimenUtil.height20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Enable the feature"),
              CupertinoSwitch(
                value: _switchValue,
                onChanged: (value) {
                  setState(() {
                    _switchValue = value;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: DimenUtil.height20),
          CupertinoSwitch(value: false, onChanged: null),
        ],
      ),
    );
  }
}
