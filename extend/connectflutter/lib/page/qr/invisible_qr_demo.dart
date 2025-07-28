// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/06/15
// Description: 
// -------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvisibleQRDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 主内容
          Center(
            child: Text(
              "欢迎来到抖音风页面",
              style: TextStyle(fontSize: 24),
            ),
          ),

          // 隐形二维码图层（几乎不可见）
          Positioned(
            bottom: 100,
            right: 40,
            child: Opacity(
              opacity: 1, // 再加一层透明度（0.01~0.05）
              child: Image.asset(
                "assets/qr/invisible_qr_002.png",
                width: 120.w,
                height: 120.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
