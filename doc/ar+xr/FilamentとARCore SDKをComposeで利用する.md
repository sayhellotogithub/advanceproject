FilamentとARCore SDKをComposeで利用する

### Filament と ARCore SDK の連携の基本的な考え方

1. ARCore SDK:
   - ARセッション（`Session`オブジェクト）を管理し、カメラ映像のフレーム、デバイスの姿勢、平面検出、ヒットテストなどのAR情報を取得します。
   - 取得したカメラ映像をテクスチャとしてFilamentに提供します。
2. Filament:
   - ARCoreから提供されたカメラ映像のテクスチャを背景としてレンダリングします。
   - 3Dモデル（glTF形式）をロードし、マテリアルやライトを設定します。
   - ARCoreの姿勢情報（カメラのポーズ）をFilamentのカメラに適用し、現実世界に合わせた3Dシーンを描画します。
   - 最終的なレンダリング結果を`SurfaceView`に描画します。
3. Jetpack Compose:
   - `AndroidView`コンポーザブルを使用して、Filamentがレンダリングを行う`SurfaceView`をComposeのUIツリーに埋め込みます。
   - UIの状態管理やユーザーインタラクション（例: 画面タップ）をComposeで処理し、ARCoreのロジックに連携させます。

### 必要な依存関係の追加

`build.gradle (app)`に以下の依存関係を追加します。Filamentのバージョンは最新の安定版を使用してください。

```
// build.gradle (app)

plugins {
    id 'com.android.application'
    id 'org.jetbrains.kotlin.android'
}

android {
    // ...
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }
    kotlinOptions {
        jvmTarget = '1.8'
    }
    buildFeatures {
        compose true
    }
    composeOptions {
        kotlinCompilerExtensionVersion '1.5.1' // お使いのKotlinバージョンに合わせる
    }
    packaging {
        resources {
            excludes += '/META-INF/{AL2.0,LGPL2.1}'
        }
    }
}

dependencies {
    // Android Studioが自動で追加するCompose関連の依存関係
    implementation(platform('androidx.compose:compose-bom:2023.08.00'))
    implementation 'androidx.compose.ui:ui'
    implementation 'androidx.compose.ui:ui-graphics'
    implementation 'androidx.compose.ui:ui-tooling-preview'
    implementation 'androidx.compose.material3:material3'
    implementation 'androidx.activity:activity-compose:1.8.2'

    // ARCore
    implementation 'com.google.ar:core:1.42.0' // 最新の安定版に合わせる

    // Filament (Core libraries)
    // Core functionality, Renderer, Engine, etc.
    implementation 'com.google.android.filament:filament-android:1.48.0' // 最新の安定版に合わせる
    implementation 'com.google.android.filament:gltfio-android:1.48.0' // glTFローダー
    implementation 'com.google.android.filament:utils-android:1.48.0' // ヘルパーユーティリティ
}
```

`AndroidManifest.xml` の設定

```
<uses-permission android:name="android.permission.CAMERA" />

<uses-feature android:name="com.google.ar.core.depth" android:required="true" />
<uses-feature android:name="android.hardware.camera.ar" android:required="true" />

```

