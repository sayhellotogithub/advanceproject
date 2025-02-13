package com.iblogstreet.advanceproject.coroutine

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import org.junit.Test

/**
 * @author junwang
 * @date 2025/02/13 15:06
 */
class CoroutineTest {
    @Test
    fun baseTest(){
        runBlocking {
            launch (Dispatchers.Default){
                (0..10).forEach{
                    println("Message #$it from the ${Thread.currentThread().name}")
                }
            }
            (0..10).forEach{
                println("Message #$it from the ${Thread.currentThread().name}")
            }
        }
    }
}