#### 依存関係を追加

https://developer.android.com/training/dependency-injection/hilt-android?hl=ja

まず、`hilt-android-gradle-plugin` プラグインをプロジェクトのルート `build.gradle` ファイルに追加します。

> ```kotlin
> plugins {
>   ...
>   id("com.google.dagger.hilt.android") version "2.44" apply false
> }
> ```

> ```kotlin
> plugins {
>   id("kotlin-kapt")
>   id("com.google.dagger.hilt.android")
> }
> 
> android {
>   ...
> }
> 
> dependencies {
>   implementation("com.google.dagger:hilt-android:2.44")
>   kapt("com.google.dagger:hilt-android-compiler:2.44")
> }
> 
> // Allow references to generated code
> kapt {
>   correctErrorTypes = true
> }
> ```

[Migrating From Dagger to Hilt](https://www.kodeco.com/14212867-migrating-from-dagger-to-hilt)
[Assisted Injection With Dagger and Hilt](https://www.kodeco.com/21395558-assisted-injection-with-dagger-and-hilt)

