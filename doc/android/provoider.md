ContentProviderを使用したデータ

## **ContentProviderとは？**

**ContentProvider** は、Androidアプリ間でデータを安全に共有するための仕組みです。
 通常、アプリのデータはサンドボックス内に隔離されていますが、ContentProviderを使うことで、他のアプリがデータにアクセスするための窓口を作ることができます。

------

## **実装方法**

### **1️⃣ ContentProviderの作成**

以下はNavi Engineから取得したPOIデータを他のアプリに提供するContentProviderの基本的な例です。

#### **NaviMetadataProvider.kt**

```kotlin
class NaviMetadataProvider : ContentProvider() {

    private lateinit var database: SQLiteDatabase

    override fun onCreate(): Boolean {
        database = context?.openOrCreateDatabase("NaviDB", Context.MODE_PRIVATE, null)!!
        database.execSQL(
            """
            CREATE TABLE IF NOT EXISTS POI (
                _id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT,
                latitude REAL,
                longitude REAL
            )
            """.trimIndent()
        )
        return true
    }

    override fun query(
        uri: Uri,
        projection: Array<String>?,
        selection: String?,
        selectionArgs: Array<String>?,
        sortOrder: String?
    ): Cursor? {
        return database.query("POI", projection, selection, selectionArgs, null, null, sortOrder)
    }

    override fun insert(uri: Uri, values: ContentValues?): Uri? {
        val id = database.insert("POI", null, values)
        context?.contentResolver?.notifyChange(uri, null)
        return ContentUris.withAppendedId(uri, id)
    }

    override fun getType(uri: Uri): String? {
        return "vnd.android.cursor.dir/vnd.example.poi"
    }

    override fun update(
        uri: Uri,
        values: ContentValues?,
        selection: String?,
        selectionArgs: Array<String>?
    ): Int {
        return database.update("POI", values, selection, selectionArgs)
    }

    override fun delete(uri: Uri, selection: String?, selectionArgs: Array<String>?): Int {
        return database.delete("POI", selection, selectionArgs)
    }
}
```

------

### **2️⃣ AndroidManifest.xmlへの登録**

次に、`AndroidManifest.xml` でContentProviderを登録します。

```xml
<provider
    android:name=".NaviMetadataProvider"
    android:authorities="com.example.navimetadata.provider"
    android:exported="true"
    android:grantUriPermissions="true">
</provider>
```

- **authorities**：プロバイダーを一意に識別する名前。他のアプリはこれを使ってアクセスします。
- **exported**：他アプリへの公開可否（`true`で公開）
- **grantUriPermissions**：アクセス許可を動的に変更したい場合に設定

------

### **3️⃣ データの追加**

POIデータを追加するには以下のようにします。

```kotlin
val values = ContentValues().apply {
    put("name", "渋谷駅")
    put("latitude", 35.658581)
    put("longitude", 139.745433)
}

contentResolver.insert(
    Uri.parse("content://com.example.navimetadata.provider/POI"),
    values
)
```

------

### **4️⃣ 他アプリからのデータ取得**

他のアプリは次のようにPOIデータを取得できます。

```kotlin

val cursor = contentResolver.query(
    Uri.parse("content://com.example.navimetadata.provider/POI"),
    null, null, null, null
)

cursor?.use {
    while (it.moveToNext()) {
        val name = it.getString(it.getColumnIndexOrThrow("name"))
        val latitude = it.getDouble(it.getColumnIndexOrThrow("latitude"))
        val longitude = it.getDouble(it.getColumnIndexOrThrow("longitude"))
        Log.d("POI", "名前: $name, 緯度: $latitude, 経度: $longitude")
    }
}
```

------

## 🚨 **セキュリティの考慮**

データを安全に共有するためには、次の点にも注意が必要です！

- **権限チェック**
   ContentProviderにアクセス制限をつけることで、特定のアプリのみにデータを公開することができます。

```xml
<provider
    android:name=".NaviMetadataProvider"
    android:authorities="com.example.navimetadata.provider"
    android:exported="true"
    android:permission="com.example.permission.READ_METADATA">
</provider>
```

- **READ/WRITE権限の定義**

`res/values/permissions.xml` に権限を追加します。

```xml
<permission
    android:name="com.example.permission.READ_METADATA"
    android:protectionLevel="signature" />
```

これにより、署名付きアプリのみにアクセスを許可することができます。



### 特定のアプリのみにデータを公開することができます

特定のアプリのみはアプリAとアプリBが同じ署名キー（keystore）を使うアプリです

### **1. keystoreの作成**

Android Studioでkeystoreを作成：

- **[Build] → [Generate Signed Bundle / APK]**
- 新しいkeystoreを作成し、パスワードとエイリアスを設定

例えば、`my-release-key.jks` を作成したとします

### **2. アプリAとアプリBの署名に同じkeystoreを使用**

**アプリAの `build.gradle`：**

```
android {
    signingConfigs {
        release {
            storeFile file("my-release-key.jks")
            storePassword "password"
            keyAlias "my-key-alias"
            keyPassword "password"
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

**アプリBの `build.gradle`：**

```
android {
    signingConfigs {
        release {
            storeFile file("my-release-key.jks")
            storePassword "password"
            keyAlias "my-key-alias"
            keyPassword "password"
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

------

### 🔒 **3. 同じ署名キーによるデータ共有**

**アプリAのContentProvider設定：**

```xml
<permission
    android:name="com.example.SHARED_PERMISSION"
    android:protectionLevel="signature" />

<provider
    android:name=".MyContentProvider"
    android:authorities="com.example.myapp.provider"
    android:permission="com.example.SHARED_PERMISSION"
    android:exported="true" />
```

**アプリBのアクセス許可：**

```xml
<uses-permission android:name="com.example.SHARED_PERMISSION" />
```

------

この方法により、**アプリAとアプリBは同じkeystoreで署名されているため、ContentProviderを使ったデータ共有が可能**になります！

### 異なるkeystoreを使っている場合

同じkeystoreを使うのは便利ですがリスクもあります。

主な危険性は次のとおりです：

- **漏洩リスク**：keystoreが外部に流出すると、悪意のある第三者がアプリを偽装できます。
- **全アプリに影響**：1つのアプリが攻撃されると、同じ署名キーの他アプリも危険にさらされます。
- **権限の乱用**：信頼しすぎると、1つのアプリが他アプリのデータに不正アクセスする可能性があります。

対策としては：

- **最小限の権限を設定**する（必要なデータだけ共有）
- **keystoreを安全に管理**する（CI/CDツールの秘密管理機能を使うなど）
- **キーを分ける**：重要なアプリごとに異なるkeystoreを使う