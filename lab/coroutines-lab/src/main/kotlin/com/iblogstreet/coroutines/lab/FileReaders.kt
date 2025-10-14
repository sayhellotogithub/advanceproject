package com.iblogstreet.coroutines.lab

/**
 * @author junwang
 * @date 2025/10/14 17:42
 */
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.async
import kotlinx.coroutines.awaitAll
import kotlinx.coroutines.channels.ReceiveChannel
import kotlinx.coroutines.channels.produce
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.flowOn
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.isActive
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.withContext
import java.nio.file.Path
import kotlin.io.path.Path
import kotlin.io.path.bufferedWriter
import kotlin.io.path.createDirectories
import kotlin.io.path.createFile
import kotlin.io.path.exists
import kotlin.io.path.forEachLine
import kotlin.io.path.readText
import kotlin.io.path.useLines


suspend fun readFile(
    path: String,
    io: CoroutineDispatcher = Dispatchers.IO
): String = withContext(io) {
    Path(path).readText()
}

suspend fun readAll(
    files: List<String>,
    io: CoroutineDispatcher = Dispatchers.IO
): List<Pair<String, Int>> = coroutineScope {
    files.map { path ->
        async { path to readFile(path, io).length }
    }.awaitAll()
}

suspend fun processLargeFile(path: String, io: CoroutineDispatcher = Dispatchers.IO) =
    withContext(io) {
        Path(path).useLines { lines ->
            lines.forEach { line ->
                // 重い処理を模擬
                println("処理中: $line")
            }
        }
    }

fun CoroutineScope.fileReader(path: Path): ReceiveChannel<String> = produce(Dispatchers.IO) {
    path.forEachLine { seq ->
        for (line in seq) {
            if (!isActive) break
            send(line.toString())
        }
    }
}

fun CoroutineScope.fileProcessor(input: ReceiveChannel<String>): ReceiveChannel<String> = produce {
    for (line in input) {
        send("Processed:${line.uppercase()}")
    }
}

fun CoroutineScope.fileWriter(outputPath: Path, input: ReceiveChannel<String>) =
    launch(Dispatchers.IO) {
        outputPath.parent?.createDirectories()
        outputPath.bufferedWriter(Charsets.UTF_8).use { write ->
            for (line in input) {
                write.appendLine(line)
            }
        }
    }

fun readLinesFlow(path: Path): Flow<String> = flow {
    path.useLines { seq -> seq.forEach { emit(it) } }
}.flowOn(Dispatchers.IO)

fun processFlow(lines: Flow<String>): Flow<String> = lines.map { "Processed:${it.uppercase()}" }

suspend fun writeFlow(outputPath: Path, lines: Flow<String>) {
    outputPath.parent?.createDirectories()
    outputPath.bufferedWriter(Charsets.UTF_8).use { w ->
        lines.collect {
            w.appendLine(it)
        }
    }
}

fun main() = runBlocking {
    val inPath: Path = Path("a.txt")
    if (!inPath.exists()) {
        inPath.createFile()
    }
    val outPath: Path = Path("b.txt")
    val reader= readLinesFlow(inPath)
    val processor = processFlow(reader)
     writeFlow(outPath,processor).let {
         println("Done ->${outPath.toAbsolutePath()}")
     }
}

//fun main() = runBlocking {
//    val inPath: Path = Path("a.txt")
//    if (!inPath.exists()) {
//        inPath.createFile()
//    }
//    val outPath: Path = Path("b.txt")
//
//    val reader = fileReader(inPath)
//    val processor = fileProcessor(reader)
//    val writerJob = fileWriter(outPath, processor)
//    writerJob.join()
//
//    println("Done ->${outPath.toAbsolutePath()}")
//
//}

//fun main() = runBlocking {
//    val files = listOf("a.txt", "b.txt", "c.txt")
//    val results = readAll(files) // 默认 IO
//    results.forEach { (path, size) ->
//        println("File $path: $size bytes")
//    }
//}
