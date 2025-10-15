package com.iblogstreet.coroutines.lab

import kotlinx.coroutines.delay
import kotlinx.coroutines.runBlocking
import kotlin.system.measureTimeMillis

/**
 * @author junwang
 * @date 2025/10/15 15:11
 */
suspend fun heavyCalculation(id: Int): Int {
    println("Start Task $id on ${Thread.currentThread().name}")
    delay(1000)
    println("End Task $id")
    return id * id
}

fun main() = runBlocking {
    val time = measureTimeMillis {
        for (i in 1..4) heavyCalculation(i)
    }
    println("処理時間：${time}ms")
}

//fun main() = runBlocking {
//    val time = measureTimeMillis {
//        val results = (1..4).map {
//            async(Dispatchers.Default) { heavyCalculation(it) }
//        }.awaitAll()
//        println("結果: $results")
//
//    }
//    println("処理時間：${time}ms")
//}