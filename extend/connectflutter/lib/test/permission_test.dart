// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PermissionTest();
  }
}

class _PermissionTest extends State<PermissionTest> {
  // final PermissionHandler _permissionHandler = PermissionHandler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          child: Text("request permisson"),
          onTap: () async {
            Map<Permission, PermissionStatus> statuses = await [
              Permission.location,
              Permission.storage,
            ].request();

            for (final entry in statuses.entries) {
              if (!entry.value.isGranted) {
                openAppSettings();
              }
            }
            print(statuses);
          },
        ),
      ),
    );
  }
}
