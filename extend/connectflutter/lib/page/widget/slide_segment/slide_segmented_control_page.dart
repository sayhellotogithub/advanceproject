// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/23
// Description:
// -------------------------------------------------------------------

import 'package:flutter/cupertino.dart';

import '../../../component/title/common_title_widget.dart';
import '../../../util/page_util.dart';

class SlideSegmentedControlPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SlideSegmentedControlPageState();
  }
}

class SlideSegmentedControlPageState extends State<SlideSegmentedControlPage> {
  int _selectedSegment = 0;

  @override
  Widget build(BuildContext context) {
    return PageUtil.buildPage(
      _buildBody(),
      CommonTitleWidget(title: "SlideSegmentedControl Example"),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.scale(
                scale: 1.5,
                child: CupertinoSlidingSegmentedControl(
                  groupValue: _selectedSegment,
                  children: {
                    0: Text('Option 1'),
                    1: Text('Option 2'),
                    2: Text('Option 3'),
                  },
                  onValueChanged: (value) {
                    // Handle value change
                    setState(() {
                      _selectedSegment = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
