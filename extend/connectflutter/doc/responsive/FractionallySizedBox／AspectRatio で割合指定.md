#### FractionallySizedBox／AspectRatio で割合指定

要素を画面幅の何％にしたいときは、`FractionallySizedBox` が便利。アスペクト比固定なら `AspectRatio` も有効です。

```
// 幅を親の60%、高さを自動
FractionallySizedBox(
  widthFactor: 0.6,
  child: Container(color: Colors.green),
);

// 常に 16:9 の比率を維持
AspectRatio(
  aspectRatio: 16 / 9,
  child: Container(color: Colors.black),
);
```