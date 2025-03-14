// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'dart:async';

import 'package:connectflutter/component/pincode/models/animation_type.dart';
import 'package:connectflutter/component/pincode/models/pin_theme.dart';
import 'package:connectflutter/component/pincode/pin_code_fields.dart';
import 'package:connectflutter/util/color_util.dart';
import 'package:connectflutter/util/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Test extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestState();
  }
}

class TestState extends State<Test> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("kdfdf"),
        ),
        body: Column(
            // child: InkWell(
            children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8),
                  child: PinCodeTextField(
                    appContext: context,
                    backgroundColor: Colors.white,
                    pastedTextStyle: TextStyle(
                      color: Colors.transparent,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    length: 6,
                    obscureText: false,
                    // obscuringCharacter: '*',
                    // obscuringWidget: FlutterLogo(
                    //   size: 24,
                    // ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    autovalidateMode: AutovalidateMode.disabled,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(16),
                      fieldHeight: 80,
                      fieldWidth: 50,
                      inactiveColor: Colors.transparent,
                      inactiveFillColor: ColorUtil.colorFFF6F6F6,
                      selectedColor: Colors.transparent,
                      selectedFillColor: ColorUtil.colorFFF6F6F6,
                      activeColor: Colors.transparent,
                      activeFillColor: ColorUtil.colorFFF6F6F6,
                    ),
                    cursorColor: ColorUtil.colorFF445FF1,
                    animationDuration: Duration(milliseconds: 300),
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                    boxShadows: [
                      // BoxShadow(
                      //   offset: Offset(0, 0),
                      //   color: Colors.black12,
                      //   blurRadius: 10,
                      // )
                    ],
                    onCompleted: (v) {
                      print("Completed");
                    },
                    // onTap: () {
                    //   print("Pressed");
                    // },
                    onChanged: (value) {
                      print(value);
                      // setState(() {
                      //   currentText = value;
                      // });
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  )),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              )
            ]
            // ),
            ));
  }
}
