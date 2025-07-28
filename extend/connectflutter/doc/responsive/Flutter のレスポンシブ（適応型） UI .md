#### Flutter のレスポンシブ（適応型） UI 

Flutter のレスポンシブ（適応型） UI を実現するための代表的な手法をいくつか紹介します。

* フレックスレイアウト（Flex／Expanded／Flexible）
* MediaQuery で画面サイズを取得
* LayoutBuilder で親コンテナの制約に応じる
* FractionallySizedBox／AspectRatio で割合指定
* OrientationBuilder で縦横向き切り替え
* FittedBox や Expanded＋FittedBox
* サードパーティパッケージの活用(responsive_framework,flutter_layout_grid,flutter_screenutil,auto_size_text )

#### フレックスレイアウト（Flex／Expanded／Flexible）
主に水平方向（`Row`）か垂直方向（`Column`）に子ウィジェットを「比率」で分配したり、「空きスペース」を自動で埋めたりするのに使います。
```
Row(
  children: [
    Expanded(flex: 2, child: Container(color: Colors.blue, height: 100)),
    Expanded(flex: 1, child: Container(color: Colors.red,  height: 100)),
  ],
)

```

#### MediaQuery で画面サイズを取得
* 画面幅・高さに応じてウィジェットツリーを切り替え可能
```
final size = MediaQuery.of(context).size;
if (size.width > 600) {
  // タブレット以上向けのレイアウト
} else {
  // スマホ向けレイアウト
}

```
#### LayoutBuilder で親コンテナの制約に応じる
画面だけでなく、カードコンテナやダイアログなど局所的にも適用できる。
```
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 800) {
      return _buildWideLayout();
    } else {
      return _buildNarrowLayout();
    }
  },
)

```
#### 割合指定
##### FractionallySizedBox：親の何％幅／高さにするか指定
```
FractionallySizedBox(
  widthFactor: 0.7,
  child: Container(color: Colors.red),
);

```
##### AspectRatio：子のアスペクト比を固定
```
AspectRatio(
  aspectRatio: 16 / 9,
  child: Container(color: Colors.black),
);
```

#### OrientationBuilder で縦横向き対応
* 端末の回転（Portrait／Landscape）に合わせてレイアウト変更
```
OrientationBuilder(
  builder: (context, orientation) {
    return orientation == Orientation.portrait
      ? _buildPortrait()
      : _buildLandscape();
  },
)
```
#### FittedBox
* 子のサイズが親を超えないよう、自動でスケールダウン

```
FittedBox(
  fit: BoxFit.scaleDown,
  child: Text('とても長いテキストを自動で縮小'),
);
```
#### responsive_framework
* [MOBILE／TABLET／DESKTOP」のように幅ごとに自動調整

* レスポンシブグリッドや行列レイアウトも提供

```

    ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      )

```

#### flutter_layout_grid
flutter_layout_grid は CSS Grid のような二次元グリッドレイアウトを Flutter で実現するライブラリです。複雑な行・列の配置や自動フローを簡潔に書けるのが特徴です。
```
    LayoutGrid(
        areas: '''
          header header  header
          nav    content aside
          nav    content .
          footer footer  footer
        ''',
        // Concise track sizing extension methods 
        columnSizes: [152.px, 1.fr, 152.px],
        rowSizes: [
          112.px,
          auto,
          1.fr,
          64.px,
        ],
        // Column and row gaps! 
        columnGap: 12,
        rowGap: 12,
        // Handy grid placement extension methods on Widget 
        children: [
          Header().inGridArea('header'),
          Navigation().inGridArea('nav'),
          Content().inGridArea('content'),
          Aside().inGridArea('aside'),
          Footer().inGridArea('footer'),
        ],
      ),
```

#### flutter_screenutil
flutter_screenutil は、デザインカンプ（例：375×812pt）に基づいて、UI のあらゆる長さ・幅・フォントサイズ・角丸などを「実機画面サイズに等比マッピング」してくれるパッケージです。具体的には、以下のような拡張プロパティを提供します。

.w / .h：幅（width）、高さ（height）を designSize に対してスケール

.sp：フォントサイズを designSize に対してスケール

.r：半径（radius）、境界線の太さなどをスケール

.sw / .sh：画面幅・画面高さのパーセント指定

```
void main() {
  runApp(
    ScreenUtilInit(
      designSize: Size(375, 812), // ここはデザインカンプのサイズ
      minTextAdapt: true,          // 文字も最小限適応させるか
      builder: (context, child) {
        return MaterialApp(
          home: child,
        );
      },
      child: MyApp(),
    ),
  );
}

Container(
      width: 300.w,           // designSize の (300/375) × 実機幅
      height: 200.h,          // designSize の (200/812) × 実機高
      alignment: Alignment.center,
      child: Text(
        'ScreenUtil Sample',
        style: TextStyle(fontSize: 16.sp), // (16/375) × 実機幅
      ),
    )
```

#### auto_size_text
AutoSizeText は、長いテキストを親コンテナに収めつつ、文字サイズを自動で縮小してくれる Flutter のパッケージです。
```
AutoSizeText(
  'Flutter は素晴らしい UI フレームワークです！長いテキストも自動で縮小。',
  style: TextStyle(fontSize: 24),
  maxLines: 2,               // 2行まで表示
  minFontSize: 12,           // 縮小しても 12 が下限
  stepGranularity: 2,        // 24→22→20→…と 2 ずつ縮小
  overflowReplacement: Text('…'), // 縮小限界を超えたら代替ウィジェット
)
```
#### まとめ
1.まずは Flutter 標準で

* Flex 系、MediaQuery、LayoutBuilder、FractionallySizedBox、FittedBox

2.必要に応じてサードパーティ
* デザイン通り等比なら flutter_screenutil
* ブレイクポイント重視なら responsive_framework


#### サードパーティパッケージ

* [flutter_screenutil](https://pub.dev/packages/flutter_screenutil)
* [flutter_layout_grid](https://pub.dev/packages/flutter_layout_grid)
* [responsive_framework](https://pub.dev/packages/responsive_framework)
* [auto_size_text](https://pub.dev/packages/auto_size_text)
