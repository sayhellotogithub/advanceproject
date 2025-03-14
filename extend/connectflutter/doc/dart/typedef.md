## **基本の使い方**

### 1️⃣ **関数型のエイリアス**

```dart
typedef Operation = int Function(int a, int b);

int add(int a, int b) => a + b;
int subtract(int a, int b) => a - b;

void main() {
  Operation op = add;
  print(op(5, 3)); // 8

  op = subtract;
  print(op(5, 3)); // 2
}
```

**解説**

- `typedef Operation = int Function(int a, int b);`
  - **Operation** という型を作成
  - **intを返す関数** で、引数は2つのint
- **add, subtract** は同じシグネチャなので **Operation** 型として代入可能

------

### 2️⃣ **レコード型のエイリアス**

Dart 3.0 以降は、**レコード型** も `typedef` で簡潔に扱えます！

```dart
typedef User = ({String name, int age, bool isActive});

User getUser() {
  return (name: 'Anna', age: 25, isActive: true);
}

void main() {
  final user = getUser();
  print('Name: ${user.name}, Age: ${user.age}, Active: ${user.isActive}');
}
```

**解説**

- **User** 型は、**name, age, isActive** を持つレコード
- レコードの型をまとめることでコードがすっきり✨

------

### 3️⃣ **ジェネリックを使ったtypedef**

ジェネリックも組み合わせ可能！

```dart

typedef Mapper<T> = T Function(T value);

String repeat(String value) => value + value;
int doubleIt(int value) => value * 2;

void main() {
  Mapper<String> stringMapper = repeat;
  Mapper<int> intMapper = doubleIt;

  print(stringMapper('Hello')); // HelloHello
  print(intMapper(10)); // 20
}
```

**解説**

- **Mapper<T>** は、**T型を引数とし、T型を返す関数**
- **String版とint版** を作成して柔軟に再利用可能

------

### ✅ **typedef を使うメリット**

1. コードの簡潔化
   - 複雑な関数型やレコード型の記述を短縮
2. 可読性の向上
   - 意味のある名前をつけることで、関数やデータの意図が明確に
3. 再利用性
   - 型を再利用して、同じ構造のデータを効率的に扱える