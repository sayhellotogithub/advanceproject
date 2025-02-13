# **Kotlin Coroutines の Job とは？**

Kotlinの `Job` は **コルーチンのライフサイクルを管理** するためのオブジェクトです。
`Job` を使うと、**コルーチンの開始・キャンセル・状態管理** ができます。

------

## **1. Job の基本**

`launch` を使うと、内部的に `Job` が生成されます。

```kotlin
import kotlinx.coroutines.*

fun main() = runBlocking {
    val job: Job = launch {
        delay(1000)
        println("Hello, Coroutines!")
    }
    
    println("Job is active: ${job.isActive}")  // true
    job.join()  // 完了を待つ
    println("Job is completed: ${job.isCompleted}")  // true
}
```

🔹 `job.isActive` → コルーチンが動作中なら `true`
🔹 `job.join()` → **終了まで待機**
🔹 `job.isCompleted` → コルーチンが完了したら `true`

------

## **2. Job のキャンセル**

`cancel()` を使うと **コルーチンをキャンセル** できます。

```kotlin
fun main() = runBlocking {
    val job = launch {
        repeat(5) { i ->
            println("Processing $i ...")
            delay(500)
        }
    }

    delay(1200)  // 1.2秒待機
    job.cancel()  // キャンセル
    job.join()  // 完了を待つ
    println("Job was cancelled")
}
```

🔹 `cancel()` で **途中でコルーチンを停止**
🔹 `join()` で **キャンセルが完了するまで待つ**

**出力（約1.2秒後に停止）:**

```kotlin
Processing 0 ...
Processing 1 ...
Processing 2 ...
Job was cancelled
```

------

## **3. `cancelAndJoin()` でスムーズに終了**

キャンセル後に `join()` するのが一般的なので、`cancelAndJoin()` を使うとスムーズ。

```kotlin

fun main() = runBlocking {
    val job = launch {
        repeat(10) {
            println("Working...")
            delay(300)
        }
    }
    
    delay(1000)
    job.cancelAndJoin()  // キャンセルして完了まで待つ
    println("Job is cancelled and finished")
}
```

------

## **4. `isActive` でキャンセルを検出**

コルーチンは **キャンセルされても直ちに停止しない** ため、`isActive` を使ってチェックできます。

```kotlin
fun main() = runBlocking {
    val job = launch {
        repeat(10) {
            if (!isActive) return@launch  // キャンセルされたら抜ける
            println("Working...")
            delay(300)
        }
    }
    
    delay(1000)
    job.cancelAndJoin()
    println("Job stopped")
}
```

🔹 `isActive` → **キャンセルされたかどうかをチェック**
🔹 **明示的に `return` しないと停止しないケースがある**

------

## **5. `Job` の階層構造**

`launch` でネストしたコルーチンは **親コルーチンがキャンセルされると、一緒にキャンセル** されます。

```kotlin
fun main() = runBlocking {
    val parentJob = launch {
        launch {
            repeat(10) {
                println("Child job running...")
                delay(500)
            }
        }
    }

    delay(1000)
    parentJob.cancel()  // 親をキャンセル → 子も止まる
    parentJob.join()
    println("Parent and child jobs cancelled")
}
```

**出力（約1秒後に停止）:**

```
Child job running...
Child job running...
Parent and child jobs cancelled
```

🔹 **親コルーチンをキャンセルすると、子コルーチンも止まる！**

------

## **6. `SupervisorJob`（子コルーチンを独立させる）**

`SupervisorJob` を使うと、**親コルーチンがキャンセルされても子コルーチンは動き続ける** ことが可能。

```kotlin
fun main() = runBlocking {
    val parentJob = SupervisorJob()

    val scope = CoroutineScope(parentJob)

    val child1 = scope.launch {
        println("Child 1 running")
        delay(1000)
        println("Child 1 done")
    }

    val child2 = scope.launch {
        println("Child 2 running")
        delay(500)
        println("Child 2 failed")
        throw Exception("Error in Child 2")
    }

    delay(700)
    println("Cancelling parent job")
    parentJob.cancel()  // SupervisorJob なので子は独立
    child1.join()
    println("Child 1 survived!")
}
```

🔹 `SupervisorJob()` を使うと **1つの子がエラーになっても他の子には影響しない！** 🚀

------

## **7. `job.children` で子コルーチンを管理**

`job.children` を使うと、親ジョブの **子コルーチンの一覧を取得** できます。

```kotlin
fun main() = runBlocking {
    val parentJob = launch {
        repeat(3) {
            launch {
                delay(1000)
                println("Child $it completed")
            }
        }
    }

    println("Children count: ${parentJob.children.count()}")  // 3
    parentJob.join()
}
```

🔹 `parentJob.children` で **子コルーチンの数を確認可能！**

------

## **8. まとめ**

✅ **`Job` はコルーチンのライフサイクル管理**
✅ **`cancel()` で停止できるが、`isActive` をチェックするとより確実**
✅ **`join()` で終了を待つ、`cancelAndJoin()` でスマートに停止**
✅ **`SupervisorJob` を使うと、親と子のキャンセルを独立できる**
✅ **`job.children` で子コルーチンの管理が可能**