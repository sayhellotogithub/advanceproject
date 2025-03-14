**Record types** は、Dart 3.0 で追加された新機能で、複数の値を簡潔にまとめるデータ構造です！
 タプルみたいなものですが、型安全かつ柔軟な使い方ができます。

### 🌟 **基本の使い方**

```dart
// 無名のレコード型
(int, String, bool) user = (25, 'Anna', true);

void main() {
  print(user.$1); // 25
  print(user.$2); // Anna
  print(user.$3); // true
}
```

**特徴**

- **$1, $2, ...** で各フィールドにアクセス
- 型推論が効く

------

### 🏷️ **名前付きレコード**

名前付きフィールドを使えば、コードがさらに読みやすくなります！

```dart
({int age, String name, bool isActive}) user = (age: 25, name: 'Anna', isActive: true);

void main() {
  print(user.age); // 25
  print(user.name); // Anna
  print(user.isActive); // true
}
```

**名前付きのメリット**

- 可読性が向上
- フィールド名でアクセスできるので、順番を気にしなくてOK

------

### 🔄 **関数の戻り値に使う**

レコード型は、複数の値を返したいときに便利です。

```dart
({int sum, int product}) calculate(int a, int b) {
  return (sum: a + b, product: a * b);
}

void main() {
  final result = calculate(3, 4);
  print('Sum: ${result.sum}, Product: ${result.product}');
}
```

------

### 🚀 **型の一致**

Dartは型安全なので、次のように異なるレコード型はエラーになります。

```dart
(int, String) user1 = (25, 'Anna');
(String, int) user2 = ('Anna', 25); // エラー！
```

------

### 🎯 **こんな時に使える！**

- 関数から複数の値を返したい
- 一時的なデータ構造が欲しい（クラスを作るほどじゃない場合）
- JSONなどのデータ構造を簡単に扱いたい