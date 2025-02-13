package com.iblogstreet.advanceproject.coroutine

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancelAndJoin
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import org.junit.Test

/**
 * @author junwang
 * @date 2025/02/13 15:39
 */
class JobTest {
    @Test
    fun jobBaseTest() {
        runBlocking {
            val job = launch {
                delay(1000)
                println(
                    "Hello, ${Thread.currentThread().name}"
                )
            }
            println("Job is active: ${job.isActive}")
            job.join()
            println("Job is completed: ${job.isCompleted}")
        }
    }

    @Test
    fun jobCancelTest() {
        runBlocking {
            val job = launch {
                repeat(5) { i ->

                    println("Processing $i ...")
                    delay(500)
                }
            }
            delay(1000)
            job.cancel()
            job.join()// 完了を待つ
            println("Job was cancelled")
        }
    }

    @Test
    fun jobCancelAndJoinTest() {
        runBlocking {
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

    }

    @Test
    fun parentJobTest() {
        runBlocking {
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
    }

    /**
     * SupervisorJob() を使うと 1つの子がエラーになっても他の子には影響しない！
     */
    @Test
    fun supervisorJobTest() {
        runBlocking {

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
    }

}