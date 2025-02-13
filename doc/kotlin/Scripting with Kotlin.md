Scripting with Kotlin

### **Scripting with Kotlin について**

Kotlin は通常、Android やバックエンド開発に使用されることが多いですが、**スクリプティング言語** としても利用できます。Kotlin のスクリプト機能を活用すると、簡単なタスクの自動化や CLI ツールの作成が可能になります。

------

## **1. Kotlin Script（`.kts`）とは？**

Kotlin のスクリプトファイルは、拡張子が **`.kts`** になっているファイルで、**main 関数を定義せずに** 直接コードを実行できます。
通常の Kotlin コードと異なり、**トップレベルでコードを書ける** のが特徴です。

**例: `script.kts`**

```
println("Hello, Kotlin Scripting!")

val name = "Anna"
println("こんにちは、$name さん！")
```

このスクリプトを実行するには、ターミナルで次のように入力します：

```
kotlinc -script script.kts
```

------

## **2. Kotlin スクリプトの実行方法**

### **① `kotlinc -script` を使う**

公式の Kotlin コンパイラ (`kotlinc`) を使って、スクリプトファイル（`.kts`）を実行できます。

```
kotlinc -script myscript.kts
```

これは、Python や Bash のスクリプト実行と同じような感覚で使えます。

------

### **② `#!/usr/bin/env kotlin` を使う（シェバン）**

スクリプトファイルの先頭に `#!/usr/bin/env kotlin` を書くことで、**Bash スクリプトのように** 実行できます。

**例: `myscript.kts`**

```
#!/usr/bin/env kotlin
println("これは Kotlin のスクリプトです！")
```

権限を与えて実行：

```
chmod +x myscript.kts
./myscript.kts
```

------

### **③ `kotlin` コマンドを使う**

`kotlin` コマンドを使うと、直接 **REPL（対話型シェル）** を開いて、1 行ずつ Kotlin のコードを実行できます。

```
kotlin
```

実行後、Kotlin のプロンプトが開くので、例えば以下のように試せます：

```
>>> println("Hello, Kotlin!")
Hello, Kotlin!
```

------

## **3. Kotlin スクリプトの実用例**

Kotlin のスクリプトは、さまざまな用途で活用できます。

### **① ファイル操作**

Kotlin スクリプトを使えば、ファイルの読み書きを簡単に実行できます。

```
val file = java.io.File("sample.txt")
file.writeText("これは Kotlin のスクリプトから書き込みました。")
println("ファイルに書き込み完了！")

val content = file.readText()
println("ファイルの内容: $content")
```

------

### **② システムコマンドの実行**

Kotlin のスクリプトでシェルコマンドを実行することも可能です。

```
import java.io.File

val result = ProcessBuilder("ls", "-la").redirectOutput(ProcessBuilder.Redirect.PIPE).start().inputStream.bufferedReader().readText()
println(result)
```

------

### **③ HTTP リクエスト**

Kotlin スクリプトで簡単に API を呼び出せます。

```
@file:DependsOn("io.ktor:ktor-client-core:2.0.0")
@file:DependsOn("io.ktor:ktor-client-cio:2.0.0")

import io.ktor.client.*
import io.ktor.client.request.*
import kotlinx.coroutines.runBlocking

val client = HttpClient()
runBlocking {
    val response = client.get("https://api.github.com")
    println(response)
}
```

このスクリプトでは、GitHub API からデータを取得しています。

------

## **4. Kotlin Script のメリット**

✅ **シンプルで軽量**
✅ **コンパイル不要（インタープリタのように実行可能）**
✅ **Kotlin の強力な型システムや機能をそのまま使える**
✅ **Gradle や IntelliJ IDEA でもサポートされている**