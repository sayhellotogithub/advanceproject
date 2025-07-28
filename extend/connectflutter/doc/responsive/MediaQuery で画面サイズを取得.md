#### MediaQuery で画面サイズを取得

画面幅・高さや縦横比に応じて UI を切り替えたい場合は `MediaQuery` を直接使います。

```
class ResponsiveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 600;

    return isWide
      ? Row(
          children: [ /* 横並びレイアウト */ ],
        )
      : Column(
          children: [ /* 縦並びレイアウト */ ],
        );
  }
}

```

* `size.width`／`size.height` でブレイクポイントを判定
* タブレット・スマホでまったく異なる構成も可能