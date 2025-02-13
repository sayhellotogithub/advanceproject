Kotlin の CoroutineScope

`CoroutineScope` は、**コルーチンのライフサイクルを管理** するための仕組みです。
`launch` や `async` を実行する際、適切な `CoroutineScope` を使うことで、**コルーチンのキャンセルや終了を安全に管理** できます。

------

## **1. CoroutineScope の基本**

### **① `CoroutineScope` の使い方**

`CoroutineScope` を使って **コルーチンを起動し、管理** できます。

```
import kotlinx.coroutines.*

fun main() = runBlocking {
    val scope = CoroutineScope(Dispatchers.Default)

    scope.launch {
        delay(1000)
        println("Coroutine finished")
    }

    println("Main thread continues...")
    Thread.sleep(2000) // 終了を待つ
}
```

✅ `CoroutineScope` はスレッドとは無関係で、**どのスレッドで動くかは `Dispatcher` による**
✅ `CoroutineScope(Dispatchers.Default)` で **CPU計算向けのスレッドで動作**

------

### **② `runBlocking` との違い**

- **`runBlocking`** → **メインスレッドをブロックする**
- **`CoroutineScope`** → **非同期でコルーチンを管理（メインスレッドは止まらない）**

```
fun main() = runBlocking {
    launch { 
        delay(1000)
        println("runBlocking - Coroutine finished")
    }
    
    println("Main thread blocked")
}
```

**`runBlocking` を使うと、メインスレッドが終了を待つため、ブロックされる。**
一方、`CoroutineScope` は **ブロックせずに非同期処理を管理** する。

------

## **2. `GlobalScope`（アプリ全体で使えるが非推奨）**

`GlobalScope` を使うと **アプリのライフサイクルと無関係にコルーチンを起動** できます。

```
fun main() {
    GlobalScope.launch {
        delay(1000)
        println("GlobalScope coroutine finished")
    }

    println("Main thread ends")
    Thread.sleep(2000) // 終了を待つ
}
```

✅ **`GlobalScope` はアプリが終了するまで生き続ける**（明示的にキャンセルしない限り）
⚠ **適切に管理しないと、メモリリークや予期せぬ動作の原因になるため、あまり推奨されない**

------

## **3. `CoroutineScope` の適切な使い方**

### **① `SupervisorScope`（子コルーチンの独立管理）**

通常の `CoroutineScope` では、**親がキャンセルされると、すべての子コルーチンもキャンセルされる**。
しかし、`SupervisorScope` を使うと、**1つの子がエラーで失敗しても他の子には影響しない**。

```
fun main() = runBlocking {
    supervisorScope {
        launch {
            delay(1000)
            println("Child 1 completed")
        }
        
        launch {
            delay(500)
            throw RuntimeException("Child 2 failed")
        }
    }

    println("SupervisorScope finished")
}
```

✅ **エラーが発生しても、他のコルーチンは影響を受けずに実行を継続できる**

------

### **② `CoroutineScope` のキャンセル**

`CoroutineScope.cancel()` を使うと、**そのスコープ内のすべてのコルーチンをキャンセル** できます。

```
fun main() = runBlocking {
    val scope = CoroutineScope(Dispatchers.Default)

    val job = scope.launch {
        repeat(5) {
            println("Running $it...")
            delay(500)
        }
    }

    delay(1200)
    scope.cancel() // すべてのコルーチンをキャンセル
    job.join()
    println("CoroutineScope cancelled")
}
```

✅ **スコープをキャンセルすると、スコープ内のすべてのコルーチンが停止する！**

------

## **4. `CoroutineScope` の作成方法**

| 方法                                  | 説明                         | 用途                   |
| ------------------------------------- | ---------------------------- | ---------------------- |
| `CoroutineScope(Dispatchers.Default)` | 一般的なスコープ             | CPU計算、非同期処理    |
| `GlobalScope`                         | アプリ全体で使える（非推奨） | シンプルな非同期処理   |
| `supervisorScope`                     | 子コルーチンを独立管理       | エラー耐性が必要な場合 |
| `runBlocking`                         | メインスレッドをブロック     | `main` 関数で使う      |

------

## 