package com.iblogstreet.coroutines.lab

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.cancelChildren
import kotlinx.coroutines.channels.ReceiveChannel
import kotlinx.coroutines.channels.produce
import kotlinx.coroutines.delay
import kotlinx.coroutines.runBlocking

/**
 * @author junwang
 * @date 2025/10/16 15:54
 */

fun CoroutineScope.produceNumbers() = produce<Int> {
    for (x in 1..10) {
        send(x)
        delay(100)
    }
}

fun CoroutineScope.produceSquares(receiveChannel: ReceiveChannel<Int>) = produce<Int> {
    for (x in receiveChannel) {
        send(x * x)
        delay(100)
    }
}

fun main() = runBlocking {
    val numbers = produceNumbers()
    val squares = produceSquares(numbers)
    for (x in squares) {
        println(x)
    }
    println("Done.")
    coroutineContext.cancelChildren()

}

//fun CoroutineScope.produceNumbers() = produce<Int> {
//    for (x in 1..5) {
//        send(x)
//        delay(100L)
//    }
//}
//
//fun main() = runBlocking {
//    val numbers = produceNumbers()
//    for (n in numbers) println("Got $n")
//    println("Done.")
//}
//fun main() = runBlocking {
//    val channel = Channel<Int>()
//    launch {
//        for (x in 1..5) {
//            channel.send(x * x)
//        }
//        channel.close()
//    }
//    for (x in channel) {
//        println(x)
//    }
//    println("Done")
//
//}
