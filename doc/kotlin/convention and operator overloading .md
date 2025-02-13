convention and operator overloading 

### **Kotlinの Convention（規約）と Operator Overloading（演算子オーバーロード）**

Kotlinでは **「演算子オーバーロード（Operator Overloading）」** を使用して、カスタムクラスで `+`, `-`, `*`, `/`, `[]`, `==` などの演算子を定義できます。
この機能は **「規約（Convention）」** に基づいており、Kotlinが特定の演算子に対応するメソッド名を決めています。

------

## **1. Convention（規約）とは？**

Kotlinでは、特定の記号（`+`, `-`, `*`, `/` など）に対応する関数名が決まっています。
例えば：

- `+` は `plus` 関数
- `-` は `minus` 関数
- `*` は `times` 関数
- `/` は `div` 関数
- `[]` は `get` 関数
  などです。

このような規約に従うことで、演算子をカスタムクラスに適用できます。

------

## **2. Operator Overloading（演算子オーバーロード）**

Kotlinでは `operator` 修飾子を使うことで、カスタムクラスに対して演算子を定義できます。

### **例①： `+` 演算子のオーバーロード**

```kotlin
data class Point(val x: Int, val y: Int) {
    operator fun plus(other: Point): Point {
        return Point(this.x + other.x, this.y + other.y)
    }
}

fun main() {
    val p1 = Point(3, 4)
    val p2 = Point(1, 2)
    val result = p1 + p2  // `plus` が呼ばれる
    println(result)  // Point(x=4, y=6)
}
```

💡 `+` を使うと `plus` 関数が呼ばれる！

------

### **例②： `\*` 演算子のオーバーロード**

```kotlin
data class Vector(val x: Int, val y: Int) {
    operator fun times(scale: Int): Vector {
        return Vector(x * scale, y * scale)
    }
}

fun main() {
    val v = Vector(2, 3)
    val scaled = v * 3  // `times` が呼ばれる
    println(scaled)  // Vector(x=6, y=9)
}
```

💡 `v * 3` という演算を `times` 関数で定義！

------

### **例③： `==` と `!=` のオーバーロード**

```kotlin
data class User(val name: String, val age: Int) {
    operator fun equals(other: Any?): Boolean {
        if (other is User) {
            return this.name == other.name && this.age == other.age
        }
        return false
    }
}

fun main() {
    val u1 = User("Alice", 25)
    val u2 = User("Alice", 25)
    println(u1 == u2)  // true
}
```

💡 `==` を使うと `equals` が呼ばれる！（デフォルトでは `data class` に自動実装される）

------

### **例④： `[]`（インデックスアクセス）のオーバーロード**

```kotlin
class Matrix(private val data: Array<IntArray>) {
    operator fun get(row: Int, col: Int): Int {
        return data[row][col]
    }
}

fun main() {
    val matrix = Matrix(arrayOf(
        intArrayOf(1, 2, 3),
        intArrayOf(4, 5, 6)
    ))
    println(matrix[1, 2])  // 6
}
```

💡 `matrix[1,2]` という構文で `get(row, col)` を呼び出せる！

------

## **3. まとめ**

✅ **Kotlinでは特定の演算子に対応するメソッド名が決まっている**（Convention）。
✅ **`operator` 修飾子を使うと演算子をオーバーロードできる**。
✅ **カスタムクラスで `+`, `-`, `\*`, `/`, `==`, `[]` などを使えるようになる**。

演算子オーバーロードを活用すると、クラスをより直感的に使いやすくできますね！ 