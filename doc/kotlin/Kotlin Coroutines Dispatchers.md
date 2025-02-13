Kotlin Coroutines の Dispatchers とは？

`Dispatchers` は **コルーチンがどのスレッド（スレッドプール）で実行されるかを制御する仕組み** です。
適切な `Dispatcher` を選ぶことで、CPU負荷の高い処理や I/O 処理を最適なスレッドで実行できます。

------

## **1. Dispatchers の種類**

| Dispatcher               | 説明                               | 主な用途                   |
| ------------------------ | ---------------------------------- | -------------------------- |
| `Dispatchers.Default`    | CPU負荷の高い処理向け（並列実行）  | データ処理、計算処理       |
| `Dispatchers.IO`         | I/O処理向け（並列実行）            | ネットワーク、ファイル操作 |
| `Dispatchers.Main`       | UIスレッド（Android専用）          | UI更新                     |
| `Dispatchers.Unconfined` | 最初のスレッドで開始、その後変更可 | 特殊用途                   |

------

## **2. Dispatchers の使い方**

### **① `Dispatchers.Default`（CPU負荷の高い処理向け）**

- **複数のスレッドを利用** し、**CPU負荷の高い計算処理** を効率よく実行
- **CPU コア数に応じたスレッドプール** を使用（例：4コアなら4スレッド）

```
import kotlinx.coroutines.*

fun main() = runBlocking {
    launch(Dispatchers.Default) {
        val result = heavyComputation()
        println("Computation result: $result")
    }
}

suspend fun heavyComputation(): Int {
    delay(1000) // 実際は時間のかかる計算
    return (1..1000000).sum()
}
```

✅ **CPU計算に最適**（マルチスレッドで効率的に処理）

------

### **② `Dispatchers.IO`（I/O処理向け）**

- **データベースアクセス、ネットワーク通信、ファイル読み書き** などのI/O処理に適している
- **スレッド数は多め**（Default より多く、並列処理向け）

```
fun main() = runBlocking {
    launch(Dispatchers.IO) {
        val data = fetchData()
        println("Fetched Data: $data")
    }
}

suspend fun fetchData(): String {
    delay(2000) // ネットワークAPIを模擬
    return "Data from API"
}
```

✅ **ネットワークやファイル操作に最適**

------

### **③ `Dispatchers.Main`（AndroidのUI処理向け）**

- **AndroidのUIスレッド** で実行
- **UI更新を安全に行う** ために使用

```
import kotlinx.coroutines.*

fun main() = runBlocking {
    launch(Dispatchers.Main) {
        val result = fetchData()
        updateUI(result)
    }
}

suspend fun fetchData(): String {
    delay(2000)
    return "New Data"
}

fun updateUI(data: String) {
    println("UI Updated: $data")  // Androidでは TextView などを更新
}
```

✅ **UIスレッド上で安全に処理を実行**（`kotlinx-coroutines-android` が必要）

------

### **④ `Dispatchers.Unconfined`（特殊用途）**

- **最初のスレッドで実行を開始し、その後は自由に切り替わる**
- 通常の開発では **あまり使わない**

```
fun main() = runBlocking {
    launch(Dispatchers.Unconfined) {
        println("Started on ${Thread.currentThread().name}")
        delay(1000)
        println("Resumed on ${Thread.currentThread().name}")
    }
}
```

✅ **UIやスレッドをまたぐ処理では非推奨**

------

## **3. `withContext()` を使ったスレッド変更**

コルーチンの中で一時的に `Dispatcher` を変更したいときは、`withContext()` を使う。

```

suspend fun fetchDataAndProcess() {
    val data = withContext(Dispatchers.IO) { fetchData() } // I/Oスレッド
    withContext(Dispatchers.Default) { processData(data) } // 計算スレッド
}

suspend fun processData(data: String) {
    println("Processing $data on ${Thread.currentThread().name}")
}
```

✅ **特定の処理だけ別スレッドで実行したい場合に便利**

------

## **4. `newSingleThreadContext()`（シングルスレッド実行）**

特定の処理を **1つのスレッドで実行** したい場合に `newSingleThreadContext()` を使う。

```
val singleThread = newSingleThreadContext("MyThread")

fun main() = runBlocking {
    launch(singleThread) {
        println("Running on ${Thread.currentThread().name}")
    }
}
```

✅ **スレッドを固定したいときに使えるが、リソースを使うため推奨されない**

------

## **5. まとめ**

| Dispatcher               | 主な用途                  | 特徴                 |
| ------------------------ | ------------------------- | -------------------- |
| `Dispatchers.Default`    | CPU計算処理               | マルチスレッド       |
| `Dispatchers.IO`         | ネットワーク・ファイルI/O | 多スレッド           |
| `Dispatchers.Main`       | UI更新（Android）         | UIスレッド           |
| `Dispatchers.Unconfined` | 特殊用途                  | 最初のスレッドを使用 |