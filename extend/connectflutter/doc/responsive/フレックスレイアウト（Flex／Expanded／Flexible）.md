`Flex`, `Expanded`, `Flexible` を使ったレイアウトは、Flutter のレスポンシブ UI の基礎中の基礎です。主に水平方向（`Row`）か垂直方向（`Column`）に子ウィジェットを「比率」で分配したり、「空きスペース」を自動で埋めたりするのに使います。

------

## 1. FlexWidget (`Row`／`Column`)

- `Row` は横ならび、`Column` は縦ならびの Flex コンテナ。
- 子ウィジェットに `Expanded`／`Flexible` を混ぜることで、余った空間の分配方法を制御可能。
- `mainAxisSize`／`crossAxisAlignment`／`mainAxisAlignment` で配置位置や詰め方も設定できます。

```
Column(
  mainAxisSize: MainAxisSize.max,            // 縦方向に親いっぱいまで伸ばす
  mainAxisAlignment: MainAxisAlignment.center, // 中央寄せ
  crossAxisAlignment: CrossAxisAlignment.stretch, // 横方向は幅いっぱい
  children: [...],
)
```

------

## 2. Expanded

- **余ったスペースを強制的に“全部”埋める**
- 複数置くと、`flex` の比率で分配
- 中の子は「できるだけ大きく」表示されます（制約に応じて）

```
Row(
  children: [
    Expanded(
      flex: 2,                  // 空き幅の 2/3 をこの子が取る
      child: Container(color: Colors.blue, height: 50),
    ),
    Expanded(
      flex: 1,                  // 空き幅の 1/3 をこの子が取る
      child: Container(color: Colors.red,  height: 50),
    ),
  ],
);
```

![Expanded の図解イメージ]

> 上記だと、青が全体空き幅の 2/3、赤が 1/3 を占める

------

## 3. Flexible

- Expanded と似ていますが、**子のサイズが「しっかり」決まっている場合は、余白を全部埋めずに「必要な分だけ」伸びる**
- `fit` プロパティがあり、以下２種類を選択できます：
  - `FlexFit.tight`（Expanded と同等：余白を全て使う）
  - `FlexFit.loose`（子の `SizedBox` 等が持つサイズまでしか伸びない）

```
Row(
  children: [
    Flexible(
      fit: FlexFit.loose,
      child: Container(color: Colors.green, width: 100, height: 50),
    ),
    Flexible(
      fit: FlexFit.tight,   // Expanded と同じ動き
      flex: 1,
      child: Container(color: Colors.orange, height: 50),
    ),
  ],
);
```

- 上記では、緑のコンテナは幅 100 固定のまま（余白を looser に埋める）、オレンジは残りを全部（余白を tight に）埋める

------

## 4. 使い分けのポイント

| ケース                                   | Expanded              | Flexible (`FlexFit.loose`)         |
| ---------------------------------------- | --------------------- | ---------------------------------- |
| 空きスペースをすべて占めたい             | ✔️                     | ❌                                  |
| 子の「最大サイズ」を尊重しつつ伸ばしたい | ❌                     | ✔️                                  |
| 複数の子で比率分配したい                 | ✔️ (`flex` で比率指定) | ✔️ (`flex` で比率指定＋`fit:loose`) |



------

## 5. 実践例：ヘッダー＋メイン＋フッター

```
dart


复制编辑
Scaffold(
  body: Column(
    children: [
      // 高さ固定のヘッダー
      Container(height: 80, color: Colors.blue),

      // メイン部分は空きスペースを全部使う
      Expanded(
        child: Container(color: Colors.grey.shade200),
      ),

      // フッターはテキストの高さに合わせて伸びる
      Flexible(
        fit: FlexFit.loose,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Text('© 2025 Your Company'),
        ),
      ),
    ],
  ),
);
```

- **ヘッダー**：高さ固定
- **メイン**：`Expanded` で画面の残りを埋める
- **フッター**：`Flexible(loose)` でテキスト量に合わせた高さに

------

### まとめ

- **`Row` / `Column`**：Flex コンテナ
- **`Expanded`**：余白を全部埋める（`flex` 指定で比率分配）
- **`Flexible`**：余白を必要分だけ埋める（`fit: loose`） or 全部埋める（`fit: tight`）
- レイアウトに合わせて使い分けることで、画面サイズやコンテンツ量の変動にも柔軟に対応できます。