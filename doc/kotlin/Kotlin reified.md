### `reified` の意義と背景

Kotlinの`reified`（リイファイド）は、**インライン関数（`inline`）とセットで使うことで、ジェネリクスの型情報を実行時に扱えるようにする**機能です。

通常、Kotlin（Java）のジェネリクスは「型消去（type erasure）」により、実行時には型情報が失われます。しかし、`reified`を使えばこの制約を回避し、`T::class` や `this is T` のようなコードが書けるようになります。

### 基本構文

```kotlin
inline fun <reified T> doSomething() {
    println(T::class)
}
```

* `inline`：関数の中身を呼び出し元に埋め込む。

* `reified T`：型`T`を実行時に取得可能にする。

### 使用例

#### 例1：クラス型を取得する

```kotlin
inline fun <reified T> printClassName() {
    println(T::class.java.name)
}

fun main() {
    printClassName<String>() // → java.lang.String
}

```

#### 例2：型判定（`is`）

```kotlin
inline fun <reified T> Any.isTypeOf(): Boolean {
    return this is T
}

fun main() {
    val value: Any = "Hello"
    println(value.isTypeOf<String>()) // → true
    println(value.isTypeOf<Int>())    // → false
}

```

#### 例3：Gsonを使った汎用デシリアライズ（`TypeToken`不要）

```kotlin
inline fun <reified T> Gson.fromJson(json: String): T {
    return this.fromJson(json, T::class.java)
}
```

### 注意点

| 制約項目             | 内容                                                    |
| -------------------- | ------------------------------------------------------- |
| `inline` が必須      | `reified` は `inline` 関数内でしか使えません            |
| 通常関数では使えない | 非`inline`関数では `T::class` や `this is T` はNG       |
| クラスには使えない   | `class Foo<reified T>` のようにクラスの型には使えません |

### `reified` を使わない場合との比較（TypeTokenとの違い）

```kotlin
// 使わない場合
val listType = object : TypeToken<List<String>>() {}.type
gson.fromJson<List<String>>(json, listType)

// reified を使った場合
inline fun <reified T> Gson.fromJson(json: String): T = fromJson(json, T::class.java)

```

### よくある用途

- RetrofitやKtorでの`TypeToken`不要なJSONパース
- `T::class.java`など型情報の取得
- 型による分岐（`when (T::class)`など）
- 型安全な JSON パースやデシリアライズ

### まとめ

| 特徴      | 説明                                       |
| --------- | ------------------------------------------ |
| `inline`  | 関数を呼び出し元に埋め込む                 |
| `reified` | 型Tを実行時に取得可能にする                |
| 主な用途  | 型チェック、型取得、リフレクションの簡略化 |

`reified` を使いこなせるようになると、**型に関する処理がグッと柔軟に、安全に**書けるようになります。Gson や Retrofit、Ktor などのライブラリとも相性抜群です。

### おまけ：`reified`の語源

- 「reify = 具象化する、具体化する」という意味の英単語
- コンパイル時の型を実行時に「具体化」して使えるということ