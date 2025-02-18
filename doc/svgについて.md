## **なぜ Flutter では SVG が使えるのに、Android（ネイティブ）では使えないのか？**

Flutter では `.svg` をそのまま使えるのに、Android（ネイティブ）では **`res/drawable` に `.svg` を直接配置できない** のは、**描画エンジンの違い** が理由です。

------

## **🚀 ① Flutter（Skia エンジン）**

Flutter は `Skia` という高性能なグラフィックエンジンを使っています。
この Skia は **ベクターグラフィックス（SVG など）をそのまま描画できる** ため、Flutter では `.svg` を直接表示できます。

### **🔹 Flutter で SVG を使う**

Flutter では `flutter_svg` ライブラリを使えば `.svg` をそのまま読み込めます。

```
import 'package:flutter_svg/flutter_svg.dart';

SvgPicture.asset("assets/my_image.svg")
```

✅ **メリット**

- `.svg` をそのまま `assets` に配置して使える
- **スケーラブル（画質が落ちない）**
- **色やサイズを簡単に変更できる**
- **Skia エンジンが直接描画を処理する**

------

## **📱 ② Android（ネイティブ - Canvas API）**

Android（ネイティブ）は、グラフィックスの描画に `Canvas API` を使っています。
この `Canvas API` は、**SVG のようなベクター形式を直接描画する機能を持っていない** ため、`.svg` を扱うには **VectorDrawable（.xml）に変換** する必要があります。

### **🔹 Android で SVG を使う方法**

1. **SVG を `VectorDrawable（.xml）` に変換して使う**（公式対応）
2. **Glide / Coil を使って `.svg` を画像として扱う**（サードパーティ対応）

------

## **🎯 ③ まとめ：なぜ Flutter は OK で、Android は NG？**

| **比較**           | **Flutter（Skia）**             | **Android（ネイティブ）**                           |
| ------------------ | ------------------------------- | --------------------------------------------------- |
| **描画エンジン**   | Skia（ベクター対応）            | Canvas API（ベクター非対応）                        |
| **SVG のサポート** | `.svg` をそのまま扱える         | `.svg` を `VectorDrawable.xml` に変換する必要がある |
| **パフォーマンス** | GPU に最適化、スムーズ          | `.xml` に変換すれば軽量になる                       |
| **拡張性**         | `.svg` のまま色やサイズ変更可能 | `.xml` に変換後、変更可能                           |

📌 **結論**

- **Flutter は Skia を使って `.svg` をそのまま描画できる**
- **Android は Canvas API なので `.svg` を扱えず、VectorDrawable に変換が必要**