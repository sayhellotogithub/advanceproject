Kotlin における **多態性（Polymorphism）** とは、同じインターフェースや親クラスを共有する異なる型のオブジェクトを、共通のメソッドで扱える仕組みのことです。Kotlin では、次のような形で多態性を実現できます。

------

### **1. 継承（Inheritance）による多態性**

Kotlin では、`open` キーワードを使ってクラスを継承可能にできます。

#### **例: 親クラスと子クラス**

```kotlin
// 親クラス
open class Animal {
    open fun makeSound() {
        println("動物の音")
    }
}

// 子クラス
class Dog : Animal() {
    override fun makeSound() {
        println("ワンワン！")
    }
}

class Cat : Animal() {
    override fun makeSound() {
        println("ニャーニャー！")
    }
}

// 多態性の利用
fun main() {
    val animals: List<Animal> = listOf(Dog(), Cat())
    
    for (animal in animals) {
        animal.makeSound() // Dog, Cat の型に応じて異なる動作をする
    }
}
```

➡ `makeSound()` メソッドを呼び出すと、オブジェクトの型に応じた実装が呼ばれます。

------

### **2. インターフェース（Interface）による多態性**

Kotlin では、`interface` を使って共通のメソッドを定義し、異なるクラスで実装できます。

#### **例: インターフェースを使った多態性**

```kotlin
// インターフェース
interface Vehicle {
    fun move()
}

// 各クラスでインターフェースを実装
class Car : Vehicle {
    override fun move() {
        println("車が走る")
    }
}

class Bicycle : Vehicle {
    override fun move() {
        println("自転車が進む")
    }
}

// 多態性の利用
fun main() {
    val vehicles: List<Vehicle> = listOf(Car(), Bicycle())

    for (vehicle in vehicles) {
        vehicle.move() // 車と自転車で異なる動作をする
    }
}
```

➡ `Vehicle` インターフェースを実装したクラス (`Car` や `Bicycle`) を同じ型（`Vehicle`）として扱うことで、多態性を実現できます。

------

### **3. 関数型プログラミングによる多態性**

Kotlin では、**高階関数やラムダ式** を使うことで関数型の多態性も実現できます。

#### **例: 高階関数を使った多態性**

```kotlin
fun executeAction(action: () -> Unit) {
    action()
}

fun main() {
    executeAction { println("ジャンプする") }
    executeAction { println("スライドする") }
}
```

➡ `executeAction` に異なるラムダ関数を渡すことで、動作を変えられます。

------

## **まとめ**

Kotlin における多態性の主な方法：

1. **継承**（親クラスのメソッドをオーバーライド）
2. **インターフェース**（異なるクラスで共通のメソッドを実装）
3. **関数型プログラミング**（高階関数やラムダ式を活用）

Kotlin は Java よりも柔軟にインターフェースを扱えるので、**インターフェースベースの多態性** を積極的に活用するのが一般的です。