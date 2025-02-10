**Sealed classes**（シールドクラス）は、Kotlin における強力な機能の一つで、特定の型階層の制限を設けることができるクラスです。これにより、コードの予測可能性や安全性が向上します。

------

### **Sealed class の特徴**

- **派生クラスを制限**: `sealed` キーワードを使って定義したクラスは、同じファイル内でのみ継承できます。つまり、外部ファイルから派生クラスを作成することができません。
- **型の安全性**: `sealed class` を使うことで、`when` 式などで列挙可能なクラスの全ての型を網羅することができ、型に対するパターンマッチングが安全に行えます。

------

### **Sealed class の基本的な使い方**

`sealed class` は、共通の基底クラスとして機能し、そのサブクラスを同じファイル内で定義します。

#### **例: Sealed class の定義**

```kotlin
// Sealed class の定義
sealed class Result

// Sealed class を継承するサブクラス
class Success(val data: String) : Result()
class Error(val message: String) : Result()
class Loading : Result()

// 使用例
fun getData(): Result {
    return Success("データが正常に取得されました")
}

fun handleResult(result: Result) {
    when (result) {
        is Success -> println("成功: ${result.data}")
        is Error -> println("エラー: ${result.message}")
        is Loading -> println("読み込み中...")
    }
}

fun main() {
    val result = getData()
    handleResult(result)
}
```

------

### **Sealed class の利点**

1. **型安全な `when` 文**
   `sealed class` を使うと、`when` 式で全てのサブクラスを網羅することができるため、チェックを忘れることなく安全に型に応じた処理を行えます。
2. **コードの予測可能性**
   サブクラスが制限されているため、型階層が明確であり、後から変更することが難しいため、予測可能な動作が保証されます。

------

### **Sealed class と Enum class の違い**

- **Sealed class**: サブクラスは任意の型を持つことができ、`sealed class` を継承することにより、クラスの階層を制限できます。
- **Enum class**: 定義された値（列挙値）のみが可能で、状態の列挙や有限の選択肢を表現するのに向いています。

#### **Enum の例**

```kotlin
enum class Direction {
    NORTH, SOUTH, EAST, WEST
}

fun printDirection(direction: Direction) {
    when (direction) {
        Direction.NORTH -> println("北")
        Direction.SOUTH -> println("南")
        Direction.EAST -> println("東")
        Direction.WEST -> println("西")
    }
}
```

`Enum` は状態や列挙を表現するのに適していますが、`sealed class` はもっと柔軟に異なる型を持つことができ、より複雑なクラス階層を表現できます。

------

### **まとめ**

- **Sealed class** は型階層を制限し、安全な型チェックを可能にします。
- **Enum class** よりも複雑な構造やデータを持つ場合、`sealed class` の方が適しています。
- **`when` 式** でサブクラスを網羅的に扱う際に、`sealed class` は非常に便利です。