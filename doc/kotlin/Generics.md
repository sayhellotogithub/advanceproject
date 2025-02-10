

### **otlinのジェネリクス（Generics）とは？**

Kotlinのジェネリクスは、**型をパラメータとして扱う仕組み** で、再利用性の高いコードを記述できます。
Javaのジェネリクスと似ていますが、Kotlin特有の**型の変性（Variance）** や**型推論** があります。

------

## **1. **基本的なジェネリクスクラス

ジェネリクスを使うと、クラスや関数の型を柔軟に変更できます。

```kotlin
class Box<T>(val value: T) {
    fun getValue(): T {
        return value
    }
}
```

📌 **T** は型パラメータ（どんな型でもOK）

```kotlin
val intBox = Box(123)      // Box<Int>
val stringBox = Box("Hello") // Box<String>

println(intBox.getValue())    // 123
println(stringBox.getValue()) // Hello
```

**→ 自動的に型が推論されるので、`Box<Int>` や `Box<String>` などの具体的な型になる。**

------

## **2. 型の変性（Variance）**

Kotlinでは、ジェネリクスの型の扱いを制御するために**「out（共変）」と「in（反変）」** を使います。

### **(1) 共変（Covariant） `out`**

- **「Tは出力専用（＝読み取り専用）」** として使われる
- **サブクラスをスーパータイプとして扱える（ListやArrayなど）**

```kotlin
interface Producer<out T> {
    fun produce(): T
}

class StringProducer : Producer<String> {
    override fun produce(): String = "Hello"
}

val producer: Producer<Any> = StringProducer() // OK（StringはAnyのサブタイプ）
println(producer.produce()) // "Hello"
```

✅ `out` を使うと、 `Producer<String>` を `Producer<Any>` に代入できる！（共変）

------

### **(2) 反変（Contravariant） `in`**

- **「Tは入力専用（＝引数としてのみ使用）」**
- **スーパータイプをサブタイプとして扱える**

```kotlin
interface Consumer<in T> {
    fun consume(item: T)
}

class AnyConsumer : Consumer<Any> {
    override fun consume(item: Any) {
        println("Consuming: $item")
    }
}

val consumer: Consumer<String> = AnyConsumer() // OK（AnyはStringのスーパータイプ）
consumer.consume("Test") // Consuming: Test
```

✅ `in` を使うと、 `Consumer<Any>` を `Consumer<String>` に代入できる！（反変）

------

## **3. 型の制約（Upper Bounds）**

ジェネリクスの型を特定の型のサブクラスに制限したい場合、`T : SuperType` を使います。

```kotlin
class Repository<T : Number>(val data: T) {
    fun getNumber(): Number = data
}

val intRepo = Repository(10)      // OK
val doubleRepo = Repository(5.5)  // OK
// val stringRepo = Repository("Hello") // エラー（StringはNumberのサブクラスではない）
```

✅ **`T : Number` によって、Tは `Number` のサブクラスのみ許可される。**

------

## **4. ジェネリクスを使った拡張関数**

Kotlinではジェネリクスを使って拡張関数も作れます。

```kotlin
fun <T> List<T>.printAll() {
    for (item in this) {
        println(item)
    }
}

val list = listOf("A", "B", "C")
list.printAll() 
// A
// B
// C
```

✅ **`<T>` を使ってどんなリストにも対応できる汎用的な関数を作れる！**

------

## **5. reified（具体化された型）**

通常、**ジェネリクスの型パラメータは実行時に消去（Type Erasure）** されますが、`inline` + `reified` を使うと実行時にも型情報を保持できます。

```kotlin
inline fun <reified T> getTypeName(): String {
    return T::class.simpleName ?: "Unknown"
}

println(getTypeName<Int>())  // Int
println(getTypeName<String>())  // String
```

✅ **通常は `T::class` などが使えないが、`reified` をつけると型情報を保持できる！**

------

## **まとめ**

| 特徴                         | 説明                                            |
| ---------------------------- | ----------------------------------------------- |
| **基本的なジェネリクス**     | `class Box<T>` で汎用的なクラスを作れる         |
| **共変（out）**              | 出力専用（リストやデータ提供側で使う）          |
| **反変（in）**               | 入力専用（関数の引数などで使う）                |
| **型の制約（Upper Bounds）** | `T : Number` のように型を制限                   |
| **reified（具象化）**        | `inline fun <reified T>` で実行時の型情報を保持 |