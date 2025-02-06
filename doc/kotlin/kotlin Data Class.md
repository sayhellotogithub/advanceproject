## ** Data Class とは？**

Kotlin の `data class` は、**データを保持するためのクラス** です。
通常のクラスと違い、**デフォルトで便利なメソッドが自動生成** されます。

------

## ** 1. Data Class の基本的な使い方**

### **通常のクラスとの違い**

```kotlin
class User(val name: String, val age: Int)
```

** 問題点:**

- `toString()` や `equals()` を手動で実装しないと、オブジェクトの比較や表示が面倒。

------

### ** Data Class を使うと**

```kotlin

data class User(val name: String, val age: Int)
```

** 自動で生成されるメソッド**

1. `toString()` → `User(name=Anna, age=25)` のように出力
2. `equals()` → 値が同じなら等しいと判断
3. `hashCode()` → ハッシュ値を自動生成
4. `copy()` → 既存のインスタンスを元に新しいインスタンスを作成

------

## **2. Data Class のメソッド**

### ** `toString()` の自動生成**

```kotlin
val user = User("Anna", 25)
println(user)  // 👉 User(name=Anna, age=25)
```

------

### **`equals()` & `hashCode()`**

```kotlin
val user1 = User("Anna", 25)
val user2 = User("Anna", 25)

println(user1 == user2)  // ✅ true（値が同じなら等しいと判定）
```

** 通常のクラスなら `false` になるが、Data Class なら `true` になる！**

------

### **`copy()` を使って一部の値を変更**

```kotlin
val user1 = User("Anna", 25)
val user2 = user1.copy(age = 26)  

println(user2)  // 👉 User(name=Anna, age=26)
```

** `copy()` を使うと、新しいインスタンスを作りつつ一部の値を変更できる。**

------

## ** 3. Data Class の制約**

 **主コンストラクタに** **`val` または `var` を使う必要がある**

```kotlin
data class Person(var name: String, val age: Int)  // ✅ OK
data class InvalidDataClass(name: String, age: Int)  // ❌ コンパイルエラー
```

**`abstract` `open` `sealed` `inner` は使えない**

```kotlin
abstract data class AbstractPerson(val name: String)  // ❌ コンパイルエラー
```

------

## ** 4. `componentN()` 関数（分解宣言 `Destructuring Declarations`）**

Data Class には `componentN()` という関数が自動生成され、変数へ分解できる。

```kotlin
val user = User("Anna", 25)
val (name, age) = user  

println(name)  // 👉 "Anna"
println(age)   // 👉 25
```

**`component1()` が `name`、`component2()` が `age` を取得する！**

------

## ** 5. `@JvmRecord`（Java の `record` と互換性を持つ）**

Kotlin 1.5 以降では `@JvmRecord` を使うことで、Java の `record`（イミュータブルなデータ構造）と互換性を持たせることができる。
（Java 17 以降で利用可能）

```java
@JvmRecord
data class User(val name: String, val age: Int)
```

------

## ** 6. Data Class を使うべき場面**

✔ **データの保持**（例: ユーザー情報、APIレスポンス）
✔ **オブジェクトの比較が必要な場面**
✔ **不変オブジェクト（Immutable Object）を作りたいとき**

------

## **まとめ**

✅ `data class` は `toString()` `equals()` `hashCode()` `copy()` などを自動生成
✅ `copy()` を使うと、既存のデータを元に変更ができる
✅ `Destructuring Declarations`（分解宣言）を利用可能
✅ Java の `record` と互換性を持つ（`@JvmRecord`）