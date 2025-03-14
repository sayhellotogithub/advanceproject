// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/native_link/verify_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommWithAndroid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CommWithAndroidState();
  }
}

class _CommWithAndroidState extends State<CommWithAndroid> {
  VerificationDialog verificationDialog = VerificationDialog();
  String token = 'Unknown battery level.';

  void getToken(String token) {
    setState(() {
      this.token = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                child: Text('Get Battery Level'),
                onPressed: () {
                  verificationDialog.getToken(getToken);
                }),
            Text(token),
          ],
        ),
      ),
    );
  }
}
