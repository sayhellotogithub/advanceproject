### **Kotlin の `inline` 修飾子とは？**

Kotlin の `inline` は **関数のインライン化** を行う修飾子で、特に **高階関数（関数を引数として受け取る関数）** で使用されます。

**`inline` を使う主な目的：**

1. **パフォーマンス向上**（関数呼び出しのオーバーヘッド削減）
2. **ラムダ式を使う高階関数での最適化**
3. **非ローカルリターン（`return` で外側の関数を抜ける）を可能にする**

------

## ** 1. `inline` の基本的な使い方**

`inline` をつけると、関数のコードが**コンパイル時に**展開され、関数呼び出しがなくなります。

###  例：通常の高階関数

```kotlin
fun normalFunction(block: () -> Unit) {
    println("Before block")
    block()
    println("After block")
}

fun main() {
    normalFunction { println("Inside block") }
}
```

**実行結果：**

```
Before block
Inside block
After block
```

 **この場合、`block()` の呼び出しには関数呼び出しのオーバーヘッドが発生する。**

------

### 例：`inline` を使う場合

```kotlin

inline fun inlineFunction(block: () -> Unit) {
    println("Before block")
    block()
    println("After block")
}

fun main() {
    inlineFunction { println("Inside block") }
}
```

実行結果（変わらない）

```
Before block
Inside block
After block
```

**`inline` の効果:**

- `inlineFunction` のコードが**そのまま展開**され、関数呼び出しがなくなる。
- **関数呼び出しのオーバーヘッドが削減**される。

------

## **2. `inline` を使うメリットとデメリット**

**メリット**

✔ **関数呼び出しのオーバーヘッドがなくなる** → パフォーマンス向上
✔ **ラムダ式のキャプチャを防げる**（`crossinline` で制御可能）
✔ **非ローカルリターンが可能**（後述）

### ❌ **デメリット**

❌ **コードサイズが増える**（関数がインライン展開されるため）
❌ **大きな関数を `inline` にすると逆にパフォーマンスが悪化する**

------

## **3. `noinline`（一部のラムダをインライン化しない）**

`inline` で関数をインライン化すると、すべてのラムダ引数もインライン化されます。
**ただし、一部のラムダをインライン化したくない場合は `noinline` を使います。**

### **`noinline` の例**

```kotlin

inline fun testInline(inlined: () -> Unit, noinline notInlined: () -> Unit) {
    inlined()  // これはインライン化される
    notInlined()  // これは通常の関数として呼び出される
}
```

**`noinline` をつけた `notInlined` は通常の関数呼び出しのままになる。**

------

## ** 4. `crossinline`（ラムダの `return` を禁止）**

通常、`inline` 関数内のラムダでは**非ローカルリターン**が可能です。
しかし、**他のスコープでラムダが呼ばれる場合、`crossinline` を使って `return` を禁止** できます。

### ** 非ローカルリターン（`return` で外側の関数を終了）**

```kotlin

inline fun test(block: () -> Unit) {
    block()  // `block()` 内で return すると `test()` も終了する
}

fun main() {
    test {
        println("Before return")
        return  // `main()` も終了してしまう
    }
    println("This will not be printed") // 実行されない
}
```

** `return` すると `main()` まで抜けてしまう！**

------

### **`crossinline` で `return` を禁止**

```kotlin

inline fun testCross(crossinline block: () -> Unit) {
    block()  // `crossinline` をつけると `return` できない
}

fun main() {
    testCross {
        println("Before return")
        // return  // ❌ コンパイルエラー
    }
    println("This will be printed")
}
```

**`crossinline` をつけると `return` できなくなる。**

------

## ** 5. `reified`（型パラメータを具体的な型にする）**

通常、ジェネリクスの型情報は**実行時には消える**（型消去）。
しかし、`inline` と `reified` を使うと、**型情報を保持** できる。

### **🚀 `reified` の例**

```kotlin

inline fun <reified T> printType() {
    println(T::class.java)  // 実行時に型を取得できる
}

fun main() {
    printType<String>()  // -> class java.lang.String
    printType<Int>()  // -> class java.lang.Integer
}
```

**👉 `reified` を使うと、型 `T` を `T::class.java` で取得できる。**

------

## ** まとめ**

✅ **`inline` を使うと関数がインライン展開され、関数呼び出しのオーバーヘッドがなくなる。**
✅ **`noinline` を使うと、一部のラムダをインライン化しないようにできる。**
✅ **`crossinline` を使うと、ラムダ内で `return` できなくなる（非ローカルリターンの禁止）。**
✅ **`reified` を使うと、型情報を保持できる（型消去を防ぐ）。**