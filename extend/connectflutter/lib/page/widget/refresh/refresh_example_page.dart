// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/05/15
// Description:
// -------------------------------------------------------------------
import 'package:connectflutter/component/list_example_widget.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';

import '../../../util/dimen_util.dart';

class RefreshExamplePage extends StatefulWidget {
  const RefreshExamplePage({super.key});

  @override
  State<RefreshExamplePage> createState() => _RefreshExamplePageState();
}

class _RefreshExamplePageState extends State<RefreshExamplePage> {
  final _controller = IndicatorController();
  bool _useCustom = true;

  void _toggleCustom(bool useCustom) {
    // if no change exit
    if (_useCustom == useCustom) return;

    setState(() {
      _useCustom = useCustom;
    });
  }

  Widget getList() {
    return ListExampleWidget(
      leading: Column(
        children: [
          ListHelpBox(
            child: Text(
              "Use the toggle on the app bar to change between CustomMaterialIndicator "
              "and the built-in RefreshIndicator widget.",
            ),
          ),
          ListHelpBox(
            margin: EdgeInsets.fromLTRB(
              DimenUtil.width16,
              0,
              DimenUtil.width16,
              DimenUtil.width16,
            ),
            child: Text("Can you spot the difference? 😉"),
          ),
        ],
      ),
      itemCount: 12,
      physics: AlwaysScrollableScrollPhysics(
        parent:
            _useCustom
                ? ClampingWithOverscrollPhysics(state: _controller)
                : const ClampingScrollPhysics(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _useCustom ? "CustomMaterialIndicator" : "RefreshIndicator",
        ),
        actions: [
          Switch(value: _useCustom, onChanged: (value) => _toggleCustom(value)),
        ],
      ),
      body: SafeArea(
        child: Container(
          child:
              _useCustom
                  ? CustomMaterialIndicator(
                    clipBehavior: Clip.antiAlias,
                    trigger: IndicatorTrigger.bothEdges,
                    triggerMode: IndicatorTriggerMode.anywhere,
                    onRefresh: () => Future.delayed(const Duration(seconds: 2)),
                    child: getList(),
                  )
                  : RefreshIndicator(
                    onRefresh: () => Future.delayed(const Duration(seconds: 2)),
                    triggerMode: RefreshIndicatorTriggerMode.anywhere,
                    child: getList(),
                  ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
