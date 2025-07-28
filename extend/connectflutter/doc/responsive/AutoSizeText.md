AutoSizeText

`AutoSizeText` は、長いテキストを親コンテナに収めつつ、文字サイズを自動で縮小してくれる Flutter のパッケージです。以下のような特徴があります。

------

## 主な特徴

- **テキストがオーバーフローする前に自動縮小**
   `maxLines` を超えそうなときに、プールされたフォントサイズ一覧から順に小さいサイズを試してくれます。
- **最小フォントサイズ／ステップ幅の設定**
   `minFontSize` で縮小の下限を、`stepGranularity` でフォントサイズを下げる刻み幅を指定できます。
- **スタンダードな `Text` 同様のスタイル指定**
   `style` プロパティや `textAlign`、`overflow` などが使えます。

------

## セットアップ

pubspec.yaml に追加：

```
dependencies:
  auto_size_text: ^3.0.0
```

インポート：

```
dart


复制编辑
import 'package:auto_size_text/auto_size_text.dart';
```

------

## 基本的な使い方

```
dart


复制编辑
AutoSizeText(
  'Flutter は素晴らしい UI フレームワークです！長いテキストも自動で縮小。',
  style: TextStyle(fontSize: 24),
  maxLines: 2,               // 2行まで表示
  minFontSize: 12,           // 縮小しても 12 が下限
  stepGranularity: 2,        // 24→22→20→…と 2 ずつ縮小
  overflowReplacement: Text('…'), // 縮小限界を超えたら代替ウィジェット
)
```

- **`style.fontSize`**：最大フォントサイズ
- **`minFontSize`**：最小フォントサイズ
- **`maxLines`**：許容する最大行数
- **`stepGranularity`**：調整ステップ（ポイント単位）
- **`overflowReplacement`**：どのサイズでも収まらないときに置き換えるウィジェット

------

## レイアウト例

```
dart


复制编辑
Container(
  width: 200,
  height: 60,
  color: Colors.grey.shade200,
  child: Padding(
    padding: const EdgeInsets.all(8),
    child: AutoSizeText(
      '非常に長いタイトルや見出しをここに置きます。',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      maxLines: 1,
      minFontSize: 10,
      stepGranularity: 1,
    ),
  ),
);
```

幅 200px のコンテナに収めたい見出しを、1行で自動縮小して収めます。

------

## FittedBox や `flutter_screenutil` との違い

- **FittedBox** は全体をビューポートに合わせて一律スケーリングしますが、文字の可読性（行間や文字間の最適化）は行いません。
- **flutter_screenutil** の `.sp` は設計稿比率ベースのフォントスケーリング。画面サイズが変わると等比スケーリングされますが、テキストの長さや行数による自動縮小はしません。
- **AutoSizeText** は「テキスト量に応じて最適なフォントサイズを選択し、オーバーフローを防ぐ」ことに特化しています。

------

## まとめ

- テキストが動的に変化して長さが読めない場合
- 見出しやラベルを必ず指定行数に収めたい場合
- 可読性を保ちつつ自動でフォントサイズを調整したい場合

に `AutoSizeText` は非常に便利です。必要に応じて `overflowReplacement` や `presetFontSizes`（あらかじめ使いたいフォントサイズのリストを渡す）を組み合わせて、レイアウトを崩さず最適な見た目を実現してください。