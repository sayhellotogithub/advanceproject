### Kotlinの `tailrec` 修飾子（Tail Recursion）とは？

Kotlinでは、**再帰処理を最適化**するために `tailrec` 修飾子を使用できます。これは **末尾再帰（Tail Recursion）** を最適化する機能で、通常の再帰に比べて**スタックオーバーフローを防ぐ**ことができます。

------

### **Tail Recursion（末尾再帰）とは？**

関数の最後（末尾）で**自身を呼び出す**形の再帰を **末尾再帰** といいます。

通常の再帰関数は、呼び出しごとに**コールスタックを積み重ねる**ため、再帰の回数が増えるとスタックオーバーフローが発生する可能性があります。しかし、末尾再帰の場合、Kotlinの `tailrec` を付けることで **コンパイラがループへ最適化** してくれるため、スタックを消費せずに処理できます。

------

### **`tailrec` の使い方**

#### **① 普通の再帰（スタックを消費する）**

```
kotlin


CopyEdit
fun factorial(n: Int): Int {
    return if (n == 1) 1 else n * factorial(n - 1)
}

fun main() {
    println(factorial(5)) // 120
}
```

**問題点**

- `factorial(5)` を計算する際、`factorial(4)`, `factorial(3)`, ... というように **コールスタックが積み重なる**。
- 再帰の深さが大きくなると、**StackOverflowError** が発生する可能性がある。

------

#### **② `tailrec` を使った最適化（ループに変換）**

```
kotlin


CopyEdit
tailrec fun factorialTail(n: Int, result: Int = 1): Int {
    return if (n == 1) result else factorialTail(n - 1, n * result)
}

fun main() {
    println(factorialTail(5)) // 120
}
```

**改善点**

- `factorialTail(5, 1)` → `factorialTail(4, 5)` → `factorialTail(3, 20)` … と、**スタックを積まずにループとして実行**される。
- 再帰の深さが増えても、**StackOverflowError を回避**できる。

------

### **`tailrec` を使う際の注意点**

1. 関数の最後（末尾）で再帰呼び出しをする必要がある
   - 末尾に `return 再帰呼び出し` がないと `tailrec` 修飾子を付けても最適化されない。
2. Kotlinコンパイラが最適化できる場合のみ適用される
   - `tailrec` をつけても、末尾再帰でない場合はコンパイルエラーになる。
3. 変数を保持したままの再帰には向かない
   - 例えば、リストを作成しながら再帰する場合は、`tailrec` を使えない。

------

### **まとめ**

- `tailrec` は **末尾再帰の最適化** に使われ、**スタックオーバーフローを防ぐ**。
- `tailrec` をつけると **ループに変換** され、メモリ効率が良くなる。
- ただし、**関数の末尾で必ず再帰呼び出しが必要** であり、それ以外のケースでは適用できない。