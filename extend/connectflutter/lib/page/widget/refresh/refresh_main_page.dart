// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/05/15
// Description:
// -------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../component/list_example_widget.dart';
import '../../../route/app_router_provider.dart';

class RefreshMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Refresh Main Page')),
      body: SafeArea(child: Container(child: getList(context))),
    );
  }

  Widget getList(BuildContext context) {
    return ListExampleWidget(
      leading: Column(
        children: [
          ListHelpBox(
            icon: Icons.adb,
            child: InkWell(
              onTap: () {
                context.push(customRefreshPath);
              },
              child: Text("Custom Refresh Page"),
            ),
          ),
          ListHelpBox(
            icon: Icons.adb,
            child: InkWell(
              onTap: () {
                context.push(refreshExamplePath);
              },
              child: Text("flutter-custom-refresh-indicator"),
            ),
          ),
          ListHelpBox(
            icon: Icons.adb,
            child: InkWell(
              onTap: () {
                context.push(lottieRefreshPath);
              },
              child: Text("lottieRefresh"),
            ),
          ),
        ],
      ),
      itemCount: 0,
      physics: AlwaysScrollableScrollPhysics(
        parent: const ClampingScrollPhysics(),
      ),
    );
  }
}
