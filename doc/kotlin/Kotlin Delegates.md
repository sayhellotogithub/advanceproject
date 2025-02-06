**Kotlin Delegates（デリゲート）とは？**

Kotlin の **Delegates（デリゲート）** は、クラスのプロパティや機能を**別のオブジェクトに委譲（委ねる）** 仕組みです。
**継承を使わずに、コードの再利用を簡単にできる！** 🚀

------

## **1. デリゲートプロパティ（`by` キーワード）**

プロパティのゲッター・セッターの処理を**別のオブジェクトに委譲** できる。

### ** `lazy`（遅延初期化）**

```kotlin
val name: String by lazy {
    println("値を初期化")
    "Anna"
}

fun main() {
    println("開始")
    println(name)  // ここで初めて初期化
    println(name)  // 2回目以降はキャッシュを使用
}
```

** 出力：**

```
開始
値を初期化
Anna
Anna
```

**初めて `name` にアクセスしたときだけ初期化が実行される！**

------

### **`observable`（値の変更を監視）**

```kotlin
import kotlin.properties.Delegates

var count: Int by Delegates.observable(0) { property, oldValue, newValue ->
    println("${property.name}: $oldValue → $newValue")
}

fun main() {
    count = 1
    count = 2
}
```

**出力：**

```makefile
count: 0 → 1
count: 1 → 2
```

 **変数の変更前後を監視できる！**

------

### ** `vetoable`（変更を制限）**

```kotlin

var age: Int by Delegates.vetoable(18) { _, old, new ->
    new >= 18  // 18歳未満は変更を拒否
}

fun main() {
    age = 20  // ✅ 変更OK
    println(age)

    age = 15  // ❌ 変更拒否
    println(age)
}
```

**出力：**

```

20
20
```

**変更を拒否するロジックを組み込める！**

------

## ** 2. クラスのデリゲーション（`by` キーワード）**

### **インターフェースの実装を委譲**

```kotlin
interface Printer {
    fun printMessage()
}

class SimplePrinter : Printer {
    override fun printMessage() = println("Hello from SimplePrinter")
}

class AdvancedPrinter(private val printer: Printer) : Printer by printer

fun main() {
    val printer = SimplePrinter()
    val advancedPrinter = AdvancedPrinter(printer)
    
    advancedPrinter.printMessage()  // 🚀 デリゲートされたメソッドが呼ばれる
}
```

**出力：**

```
Hello from SimplePrinter
```

 **`AdvancedPrinter` は `SimplePrinter` の `printMessage()` をそのまま利用できる！**

------

## ** 3. デリゲートの使いどころ**

 **プロパティの初期化を遅らせたい（`lazy`）**
 **値の変更を監視したい（`observable`）**
**ロジックを他のオブジェクトに委譲したい（クラスデリゲーション）**

------

## ** まとめ**

✔ **`by` を使うと、プロパティやクラスの動作を他のオブジェクトに委譲できる！**
✔ **`lazy`、`observable`、`vetoable` など、便利なプロパティデリゲートが用意されている！**
✔ **継承の代わりにデリゲートを活用すると、コードがシンプル＆柔軟に！** 

💡 **Kotlin の Delegates を使って、コードの再利用を最大化しよう！** 