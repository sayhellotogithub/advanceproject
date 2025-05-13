Android 8.0以降では、ShortcutManagerを使用したより洗練された方法もあります

最新のAndroidではAdaptive Iconsや、より新しいAPIを使った方法も検討すべきです。

#### どうやって実現するの？

Android では `AndroidManifest.xml` に複数の **エイリアス（別のランチャーアイコン）** を用意しておき、
 そのうち1つだけを有効化することで「アイコン変更」を実現します。

複数のアクティビティエイリアス（別名）にそれぞれ別のアイコンを割り当てて、動的に切り替える方法です。

#### 実装手順（Flutter + Android）

1. Android 側に複数のランチャーエイリアスを追加

```xml
<activity
    android:name=".MainActivity"
    android:exported="true"
    android:launchMode="singleTop"
    android:theme="@style/LaunchTheme"
    android:configChanges="orientation|keyboardHidden|keyboard|screenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
    android:hardwareAccelerated="true"
    android:windowSoftInputMode="adjustResize">

    <intent-filter>
        <action android:name="android.intent.action.MAIN"/>
        <category android:name="android.intent.category.LAUNCHER"/>
    </intent-filter>
</activity>

  <activity-alias
            android:name=".MainActivity.Default"
            android:enabled="true"
            android:exported="true"
            android:targetActivity=".MainActivity"
            android:icon="@mipmap/ic_launcher">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity-alias>

        <!-- Alternate icon alia #1-->
        <activity-alias
            android:name=".MainActivity.IconOne"
            android:enabled="false"
            android:exported="true"
            android:icon="@mipmap/ic_launcher_alt1"
            android:targetActivity=".MainActivity">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />

            </intent-filter>
        </activity-alias>
        <!-- Alternate icon alias #2-->
        <activity-alias
            android:name=".MainActivity.IconTwo"
            android:enabled="false"
            android:exported="true"
            android:icon="@mipmap/ic_launcher_alt2"
            android:targetActivity=".MainActivity">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity-alias>
```

2. `res/mipmap` にアイコンを追加

- `ic_launcher_alt1.png`
- `ic_launcher_alt2.png`

を `mipmap` ディレクトリに追加

3. Flutter 側から `MethodChannel` を使ってネイティブコードを呼ぶ

```dart
import 'package:flutter/services.dart';

class IconChanger {
  static const _channel = MethodChannel('com.iblogstreet.icon_changer');

  static Future<void> changeIcon(String aliasName) async {
    await _channel.invokeMethod('changeIcon', {'alias': aliasName});
  }
}

```

4. Android側ネイティブコード（Kotlin）

```kotlin
import android.content.ComponentName
import android.content.pm.PackageManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.iblogstreet.icon_changer"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "changeIcon") {
                val aliasName = call.argument<String>("aliasName")
                if (aliasName != null) {
                    changeIcon(aliasName)
                    result.success("Icon changed to $aliasName")
                } else {
                    result.error("INVALID_ARGUMENT", "Alias Name is null", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun changeIcon(aliasName: String) {
        try {
            val packageManager = packageManager
            val packageName = packageName

            val activityToEnable = when (aliasName) {
                "IconOne" -> "$packageName.MainActivity.IconOne"
                "IconTwo" -> "$packageName.MainActivity.IconTwo"
                else -> "$packageName.MainActivity.Default"
            }
            packageManager.setComponentEnabledSetting(
                ComponentName(this, activityToEnable),
                PackageManager.COMPONENT_ENABLED_STATE_ENABLED,
                PackageManager.DONT_KILL_APP
            )

            // 次に他のエイリアスを無効化
            val aliasList = listOf(
                "$packageName.MainActivity.Default",
                "$packageName.MainActivity.IconOne",
                "$packageName.MainActivity.IconTwo"
            )

            for (alias in aliasList) {
                if (alias != activityToEnable) {
                    packageManager.setComponentEnabledSetting(
                        ComponentName(packageName, alias),
                        PackageManager.COMPONENT_ENABLED_STATE_DISABLED,
                        PackageManager.DONT_KILL_APP
                    )
                }
            }


        } catch (e: Exception) {
            e.printStackTrace()
        }


    }
```