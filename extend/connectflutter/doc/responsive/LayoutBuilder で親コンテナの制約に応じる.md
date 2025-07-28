#### LayoutBuilder で親コンテナの制約に応じる

`LayoutBuilder` の `BoxConstraints` を使えば、親ウィジェットに渡される最大幅・高さに合わせて描画を変えられます。

```
dart


复制编辑
LayoutBuilder(builder: (context, constraints) {
  if (constraints.maxWidth > 800) {
    return _buildWideLayout();
  } else {
    return _buildNarrowLayout();
  }
});
```

- 画面全体だけでなく、任意のコンテナ内部でも同じ手法が使える
- ネストしたレスポンシブが可能