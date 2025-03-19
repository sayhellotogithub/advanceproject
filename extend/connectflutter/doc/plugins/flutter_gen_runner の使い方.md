flutter_gen_runner` は Flutter のコード生成ツールで、`pubspec.yaml` にアセットやフォント、カラーパレットなどを定義し、それらを型安全にアクセスできるコードを自動生成するためのパッケージです。

## 🔹 `flutter_gen_runner` の使い方

### 1️⃣ **`flutter_gen_runner` を `pubspec.yaml` に追加**

まず、`pubspec.yaml` に `flutter_gen_runner` を追加します。

```yaml
dev_dependencies:
  flutter_gen_runner: ^5.10.0
  build_runner: ^2.4.6  # `flutter_gen_runner` を実行するために必要
```

📌 **`flutter_gen_runner` は `dev_dependencies` に追加してください。**
 （本番環境では不要なため、開発環境専用の依存関係にします。）

------

### 2️⃣ **`flutter_gen` の設定を追加**

`pubspec.yaml` に以下の設定を追加します。

```yaml
flutter_gen:
  output: lib/gen/  # 生成されたコードの出力先
  line_length: 80  # コードの行の長さ
  integrations:
    flutter_svg: true  # `flutter_svg` を使っている場合
    flare_flutter: false  # `flare_flutter` を使わない場合（必要に応じて変更）
  assets:
    enabled: true  # アセットを生成する
  fonts:
    enabled: true  # フォントを生成する
```

------

### 3️⃣ **コードを自動生成**

以下のコマンドを実行して、Flutter のリソース用の Dart コードを生成します。

```
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

これで `lib/gen/` に `assets.gen.dart` などのファイルが生成され、アセットやフォントを型安全に使用できるようになります。

------

### 4️⃣ **生成されたコードを使う**

例えば、画像アセット（`assets/images/logo.png`）を使う場合、次のように記述できます。

```dart
import 'package:my_project/gen/assets.gen.dart';

Image logoImage = Image.asset(Assets.images.logo.path);
```

フォントも型安全に使用できます。

```dart
Text(
  'Hello, FlutterGen!',
  style: TextStyle(
    fontFamily: FontFamily.roboto, // 事前に定義されたフォント名
  ),
);
```

------

### 5️⃣ **（オプション）ファイルを監視して自動生成**

変更を監視しながら自動生成するには、以下のコマンドを実行すると便利です。

```
flutter pub run build_runner watch
```

------

## 🎯 まとめ

✅ `flutter_gen_runner` を `pubspec.yaml` に追加
 ✅ `flutter_gen` の設定を `pubspec.yaml` に記述
 ✅ `flutter pub run build_runner build` でコードを生成
 ✅ 生成された型安全なコード (`Assets.images.logo.path` など) を使う