package com.iblogstreet.coroutines.lab

import kotlinx.coroutines.*
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.SharedFlow
import kotlinx.coroutines.flow.asFlow
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.flow.filter
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.flow.onEach
import kotlinx.coroutines.flow.take

/**
 * @author junwang
 * @date 2025/10/16 16:51
 *
 */
val counter = MutableStateFlow(0)

fun main() = runBlocking {
    launch {
        repeat(3) {
            delay(100)
            counter.value = it
        }
    }

//    delay(250)
    counter.collect { println("Collector: $it") }
    println("dfdf")
}


//val events = MutableSharedFlow<String>()
//
//fun main() = runBlocking {
//    launch {
//        delay(100)
//        events.emit("Hello World!")
//    }
//    launch {
//        delay(300)
//        events.emit("Hello today!")
//    }
//
//    launch {
//        events.collect { println("Collector1: $it") }
//    }
//
//    launch {
//        delay(200)
//        events.collect { println("Collector2: $it") }
//    }
//
//    println()
//}

//fun main() = runBlocking {
//   val _events = MutableSharedFlow<String>(
//        replay = 0,              // 過去のイベントを再送しない
//        extraBufferCapacity = 1   // バッファ1件（tryEmit成功しやすく）
//    )
//    launch {
//        _events.tryEmit("Hello")
//    }
//    val events: SharedFlow<String> = _events
//    events.collect{
//        println(it)
//    }
//
//

// 発火


//    println()
//    (1..10).asFlow()
//        .filter { it % 2 == 0 }
//        .map { it * it }
//        .onEach { println("Emitting $it") }
//        .take(3)
//        .collect { println("Received $it") }
//}
//val counter = MutableStateFlow(0)
//
//fun main() = runBlocking {
//    launch {
//        repeat(3) {
//            delay(100)
//            counter.value++
//        }
//    }
//
//    counter.collect { println("Counter = $it") }
//
//    println("Done")
//}
//fun simpleFlow(): Flow<Int> = flow {
//    for (i in 1..3) {
//        delay(100)
//        emit(i)
//    }
//}
//
//fun main() = runBlocking {
//    simpleFlow().collect { value ->
//        println("Received: $value")
//    }
//}