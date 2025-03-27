// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/27
// Description:
// -------------------------------------------------------------------

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 方法1: AnnotatedRegionを使用したステータスバー設定
class CustomStatusBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        // カスタムステータスバーのスタイル
        statusBarColor: Colors.green.shade50, // 半透明の緑
        statusBarIconBrightness: Brightness.light, // アイコンを明るい色に
        statusBarBrightness: Brightness.dark, // iOS用の背景の明るさ
      ),
      child: Scaffold(
        body: Center(
          child: Text(
            'カスタムステータスバーページ',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

// 方法2: SystemChrome.setSystemUIOverlayStyleを使用
class DefaultStatusBarPage extends StatefulWidget {
  @override
  _DefaultStatusBarPageState createState() => _DefaultStatusBarPageState();
}

class _DefaultStatusBarPageState extends State<DefaultStatusBarPage> {
  @override
  void initState() {
    super.initState();
    // ページ表示時にステータスバーのスタイルを設定
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.blue, // 青色のステータスバー
        statusBarIconBrightness: Brightness.dark, // アイコンを濃い色に
      ),
    );
  }

  @override
  void dispose() {
    // ページを離れる時に元のスタイルに戻す
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('デフォルトステータスバーページ', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

// 方法3: 透明ステータスバーページ
class TransparentStatusBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // 完全に透明
        statusBarIconBrightness: Brightness.dark, // アイコンの色
      ),
      child: Scaffold(
        body: Stack(
          children: [
            // 背景画像やコンテンツ
            CachedNetworkImage(
              imageUrl:
                  "https://cdn.pixabay.com/photo/2016/08/11/23/48/pnc-park-1587285_1280.jpg",
              width: double.infinity,
              fit: BoxFit.cover,
              height: double.infinity,
            ),

            Center(
              child: Text(
                '透明ステータスバーページ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
