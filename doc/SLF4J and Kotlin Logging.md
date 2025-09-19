### はじめに

Android や Kotlin マルチモジュール開発において、**ログ管理**は欠かせません。

- 単純に `android.util.Log` を使うとコードが散らばる
- 直接 `SLF4J` を使うと Kotlin らしさが弱い

最新版本

- **kotlin-logging 7.0.13**（2025-08-19）[mvnrepository.com](https://mvnrepository.com/artifact/io.github.oshai/kotlin-logging-jvm/7.0.13?utm_source=chatgpt.com)
- **SLF4J 稳定版 2.0.17**（2025-02-25）[slf4j.org+1](https://www.slf4j.org/download.html?utm_source=chatgpt.com)



そこで登場するのが **Kotlin Logging**。
これは **SLF4J の軽量ラッパー** であり、Kotlin スタイルのシンプルな記述を可能にします。

------

### 1. Kotlin Logging とは？

依存関係:

```gradle
implementation("io.github.oshai:kotlin-logging-jvm:7.0.13")
implementation("org.slf4j:slf4j-api:2.0.17")
```

使い方:

```gradle
import io.github.oshai.kotlinlogging.KotlinLogging

private val log = KotlinLogging.logger {}

fun login(user: String) {
    log.info { "User logged in: $user" }
    log.debug { "Debug details..." }
}
```

#### 特徴

- Kotlin の **ラムダ構文**で遅延評価可能（不要な文字列連結を避ける）
- `SLF4J` に完全準拠 → バックエンドを差し替え可能

------

### 2. SLF4J と実装の関係

SLF4J 自体は **Facade（門面）** であり、実際の出力は「バインディング」によって決まります。

#### 主なバインディング

- **slf4j-android** → `Logcat` 出力
- **slf4j-simple** → 標準エラー出力（主にテスト用）
- **slf4j-nop** → すべてのログを無効化
- **logback-classic** → サーバーで定番、強力な設定可能

------

### 3. Android × Kotlin Logging 実践構成

#### `libs.versions.toml`

```toml
[versions]
slf4j = "2.0.17"
klogging = "7.0.13"

[libraries]
klogging-jvm     = { module = "io.github.oshai:kotlin-logging-jvm", version.ref = "klogging" }
klogging-android = { module = "io.github.oshai:kotlin-logging-android", version.ref = "klogging" }
slf4j-api        = { module = "org.slf4j:slf4j-api", version.ref = "slf4j" }
slf4j-android    = { module = "uk.uuid.slf4j:slf4j-android", version = "2.0.17-0" }
slf4j-simple     = { module = "org.slf4j:slf4j-simple", version.ref = "slf4j" }
slf4j-nop        = { module = "org.slf4j:slf4j-nop", version.ref = "slf4j" }
```

#### `app/build.gradle.kts`

```gradle
dependencies {
    implementation(libs.slf4j.api)
    implementation(libs.klogging.jvm)

    // Debug: Logcat 出力
    debugImplementation(libs.slf4j.android)

    // Release: ログ無効化
    releaseImplementation(libs.slf4j.nop)

    // テスト: コンソール出力
    testImplementation(libs.slf4j.simple)
}
```

------

### 4. マルチモジュールでの推奨依存

- **domain/data 層** → `slf4j-api` + `kotlin-logging` のみ
- **app 層** → 実際の実装（android / nop）を切り替え
- **test 層** → `slf4j-simple`

こうすることで **ログの依存を上位層に閉じ込められる**。
実装を差し替えても `domain` コードは一切変更不要。

------

### 5. メリットまとめ

- Kotlin らしい簡潔なログ記述
- SLF4J を介してバックエンドを柔軟に切り替え可能
- 環境ごとに「出す/出さない」を制御可能（Debug=Logcat, Release=NOP）
- マルチモジュールでも責務を分離できる

------

### 6. まとめ

- **Kotlin Logging 7.0.13** + **SLF4J 2.0.17** が現時点の安定構成
- Android 開発では `debug=slf4j-android`、`release=slf4j-nop`、`test=slf4j-simple` がベストプラクティス
- マルチモジュールでは domain/data は API のみ依存し、app 層で実装を注入する

https://qiita.com/nozomi2025/items/ef4d487cdb87c6b5db87
