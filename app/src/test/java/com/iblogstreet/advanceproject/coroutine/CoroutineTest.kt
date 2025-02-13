package com.iblogstreet.advanceproject.coroutine

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.async
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import org.junit.Test

/**
 * @author junwang
 * @date 2025/02/13 15:06
 */
class CoroutineTest {
    @Test
    fun baseTest() {
        runBlocking {
            launch(Dispatchers.Default) {
                (0..10).forEach {
                    println("Message #$it from the ${Thread.currentThread().name}")
                }
            }
            (0..10).forEach {
                println("Message #$it from the ${Thread.currentThread().name}")
            }
        }
    }

    @Test
    fun asynTest() {
        runBlocking {
            val deferred = async {
                delay(1000)
                "Hello from async!"
            }

            println("Waiting for result...")
            try {
                val result = deferred.await()// 結果を取得
                println(result)
            } catch (e: Exception) {
                println("Caught exception in async: ${e.message}")
            }


        }
    }
}