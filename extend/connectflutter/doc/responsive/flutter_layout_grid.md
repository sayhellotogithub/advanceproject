flutter_layout_grid

`flutter_layout_grid` は CSS Grid のような二次元グリッドレイアウトを Flutter で実現するライブラリです。複雑な行・列の配置や自動フローを簡潔に書けるのが特徴です。

------

## コア概念

1. **列サイズ・行サイズ（GridTrack）**
   - `fr`：残余スペースを比率で分配
   - 固定：`px(100)` や `percent(20)`
2. **配置指定（GridPlacement）**
   - `columnStart` / `rowStart` で開始位置を指定
   - `columnSpan` / `rowSpan` で跨ぎ数を指定
3. **自動配置（Auto Placement）**
   - `.withAutoPlacement()` を使うと、残ったセルに自動で流し込まれる

------

## インストール

`pubspec.yaml` に追記してインストール：

```
yaml


复制编辑
dependencies:
  flutter_layout_grid: ^1.0.0
bash


复制编辑
flutter pub get
```

------

## シンプルな使い方

```
dart


复制编辑
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

LayoutGrid(
  columnSizes: [px(100), 1.fr, px(80)],  // 3 列：100px｜残余1｜80px
  rowSizes:    [px(50), auto],           // 2 行：50px｜自動
  columnGap: 12, rowGap: 12,             // 列間・行間のギャップ
  children: [
    // (0,0) に 1×1 マスで配置
    Container(color: Colors.blue)
      .withGridPlacement(columnStart: 0, rowStart: 0),

    // (0,1) に 2 列分を跨いで配置
    Container(color: Colors.green)
      .withGridPlacement(columnStart: 1, columnSpan: 2, rowStart: 0),

    // 残りマスを自動で埋める
    Container(color: Colors.red)
      .withAutoPlacement(),
  ],
);
```

------

## 便利な機能

- **`repeat()`**
   同じトラックを繰り返し定義

  ```
  dart
  
  
  复制编辑
  columnSizes: repeat(4, 1.fr), // 4 列を等分
  ```

- **サブグリッド（subGrid）**
   親グリッド内にさらに小グリッドを配置

  ```
  dart
  
  
  复制编辑
  LayoutGrid.subGrid(
    columnStart: 0, rowStart: 1,
    columnSizes: repeat(2, 1.fr),
    rowSizes: [auto],
    children: [ … ],
  ),
  ```

- **動的なブレイクポイント対応**
   `MediaQuery` や `LayoutBuilder` と組み合わせて、画面幅に応じて `columnSizes`／`rowSizes` を切り替え

------

## 適したユースケース

- **ダッシュボード**：多種多様なカードやチャートを格子状に並べたい
- **複雑なフォーム**：ラベルと入力欄をグリッドで美しく配置
- **レスポンシブ表現**：大画面では多列、小画面では少列に自動調整

------

## 他のレイアウト手法との比較

| 特性             | flutter_layout_grid     | Row/Column/Flex | responsive_framework |
| ---------------- | ----------------------- | --------------- | -------------------- |
| 二次元グリッド   | ◯                       | ✕（一方向のみ） | ✕                    |
| `fr` 単位対応    | ◯                       | —               | —                    |
| 自動フロー配置   | ◯ (`withAutoPlacement`) | —               | —                    |
| ブレイクポイント | 自前で実装可            | 自前で実装      | ◯（組み込み）        |



------

**まとめ**
 複雑な行・列制御や自動配置が必要な場面では `flutter_layout_grid` が非常に強力です。シンプルな一方向レイアウトなら `Row`／`Column`、断点ベースの大規模レスポンシブなら `responsive_framework` と使い分けてください。