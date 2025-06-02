### Android向けなら：

| フレームワーク                            | 特徴                                                         |
| ----------------------------------------- | ------------------------------------------------------------ |
| **ARCore + Android Studio (Kotlin/Java)** | Google公式。原生AR機能をフル活用。ARカメラ、平面検出、物体追跡など対応。 |
| **Sceneform**                             | ARCore用の3Dシーン構築ライブラリ。現在はサードパーティが継続開発中。 |
| **Unity + AR Foundation**                 | クロスプラットフォーム。iOS / Android 両対応。UIやアニメにも強い。 |
| **Flutter + ar_flutter_plugin**           | 軽量AR体験が可能。Flutter好きにおすすめ（ただし機能制限あり）。 |

## 例：Android Studio + ARCore を使った構成

### 必要な依存（build.gradle）

```
dependencies {
    implementation 'com.google.ar:core:1.40.0'
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'androidx.activity:activity-compose:1.7.2'
}
```

### マニフェスト権限：

```
<uses-permission android:name="android.permission.CAMERA"/>
<uses-feature android:name="android.hardware.camera.ar" android:required="true"/>
```

### 基本的な構成：

- `ArFragment` でカメラビューを表示
- `Session` で ARCore 機能を制御
- 平面検出 → 3Dモデルを配置（glTF, objなど）

------

## **Android Studio + ARCore + Sceneform（再構築版）**

| 項目                 | 内容                                                         |
| -------------------- | ------------------------------------------------------------ |
| 対応プラットフォーム | Android 専用                                                 |
| 言語                 | Kotlin / Java                                                |
| 主な技術             | ARCore（Google純正）＋ Sceneform（簡単な3D表示フレームワーク） |
| 特徴                 | FlutterやUnityを使わず、AndroidアプリとしてネイティブにAR教材を作れる |



## アプリ構成イメージ（教育AR）

- 📷 カメラをかざすと、机の上に **人体/惑星/恐竜** の3Dモデルが浮かぶ
- 🖐️ モデルを **拡大・回転・タップ** で操作できる
- ℹ️ モデルをタップすると **解説テキストや音声** を表示
- ✅ すべて Kotlin + ARCore で開発でき



## 開発手順（概要）

### ① Android Studio 環境準備

- `minSdkVersion = 24` 以上
- `compileSdkVersion = 34`（推奨）
- AR対応端末 or Emulator（Pixel系推奨）

### ② 必要な依存（build.gradle）

```
dependencies {
    implementation 'com.google.ar:core:1.40.0'
    implementation 'com.gorisse.thomas.sceneform:sceneform:1.21.0' // Jetpack対応Sceneform
}
```

### ③ マニフェストにAR機能追加

```
<uses-permission android:name="android.permission.CAMERA" />
<uses-feature android:name="android.hardware.camera.ar" android:required="true" />
```

### ④ 3Dモデルを用意（例：glb, gltf, sfb）

- https://sketchfab.com や https://poly.cam などで教育用モデルを探せます。
- 例：「solar_system.glb」や「human_heart.glb」

### ⑤ コードでモデルを表示（簡易例）

```
val renderableFuture = ModelRenderable.builder()
    .setSource(context, Uri.parse("solar_system.glb"))
    .setIsFilamentGltf(true)
    .build()

renderableFuture.thenAccept { model ->
    val anchorNode = AnchorNode(anchor)
    val node = TransformableNode(arFragment.transformationSystem).apply {
        renderable = model
        setParent(anchorNode)
    }
    arFragment.arSceneView.scene.addChild(anchorNode)
}
```

#### 太陽系ARアプリでできること（イメージ）

| 機能                                                         | 内容 |
| ------------------------------------------------------------ | ---- |
| ☀️ カメラで机を映すと太陽が表示される                         |      |
| 🪐 太陽のまわりに各惑星（水星〜海王星）を表示                 |      |
| 🔁 惑星を回転・拡大できる（インタラクティブ）                 |      |
| 📘 惑星をタップするとその説明が出る（例：距離・温度・衛星など） |      |
| 🎙️ 音声で説明してくれる（TextToSpeech）も追加可能             |      |

## 実装方針（ARCore + Sceneform で構築）

| 構成要素         | 内容                                                         |
| ---------------- | ------------------------------------------------------------ |
| 使用技術         | Android Studio + Kotlin + ARCore + Sceneform 1.21            |
| モデル形式       | `.glb` または `.gltf` 形式（Google推薦の3D形式）             |
| 表示方法         | 平面検出 → Anchor に 3Dモデル配置（太陽と各惑星）            |
| 解説UI           | タップで `AlertDialog` or `BottomSheet` 表示 or 音声読み上げ |
| モデルサイズ調整 | 惑星の大きさや距離をわかりやすく調整（スケーリング）         |

## 無料で使える太陽系3Dモデル素材

### 1. Sketchfab – Solar System GLTF コレクション

Sketchfabでは、太陽、地球、火星、木星などの惑星を含む16種類の高品質な3Dモデルが公開されています。これらのモデルは `.glb` 形式で提供されており、ARアプリに直接組み込むことが可能です。

🔗 Solar System GLTF コレクション（Sketchfab）

### 2. Free3D – 太陽系モデル

Free3Dでは、太陽系全体や個別の惑星（地球、火星、金星など）の3Dモデルが無料で提供されています。ファイル形式は `.blend`、`.obj`、`.fbx` などがあり、必要に応じて `.glb` 形式に変換して使用できます。

🔗 太陽系モデル（Free3D）

### 3. CGTrader – フォトリアルな太陽系モデル

CGTraderでは、フォトリアルなテクスチャを持つ太陽系の3Dモデルが多数公開されています。これらのモデルは `.blend`、`.fbx`、`.obj` 形式で提供されており、リアルな表現を求める教育アプリに適しています。

🔗 太陽系モデル（CGTrader）

### 4. NASA 3D Resources

NASAの公式サイトでは、地球や月、火星などの実際のデータに基づいた3Dモデルが無料で提供されています。これらのモデルは `.glb` 形式でダウンロード可能で、教育目的での利用に最適です。

🔗 [NASA 3Dモデル（地球）](https://solarsystem.nasa.gov/gltf_embed/2393/)

### 5. STEM Forged – Mini Solar System

STEM Forgedでは、教育用に設計されたシンプルな太陽系モデルが提供されています。このモデルは `.glb` 形式で、軽量かつ編集可能なため、アプリへの組み込みが容易です。

🔗 Mini Solar System（STEM Forged）

------

## 