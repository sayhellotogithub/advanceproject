package com.iblogstreet.coroutines.lab

import kotlinx.coroutines.TimeoutCancellationException
import kotlinx.coroutines.delay
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.withTimeout
import kotlinx.coroutines.withTimeoutOrNull

/**
 * @author junwang
 * @date 2025/10/16 14:31
 */

//fun main() = runBlocking {
//    try {
//        withTimeout(1300L) {
//            repeat(1000) { i ->
//                println("Some expensive computation $i ...")
//                delay(500L)
//
//            }
//        }
//    } catch (e: TimeoutCancellationException) {
//        println("TimeoutCancellationException was thrown with message: ${e.message}")
//
//    }
//}

fun main() = runBlocking {
    val result = withTimeoutOrNull(1500L){
        repeat(1000) { i ->
            println("Some expensive computation $i ...")
            delay(500L)

        }
        "Done"
    }
    println("Result: $result")
}