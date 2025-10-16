package com.iblogstreet.coroutines.lab

import kotlinx.coroutines.*

/**
 * @author junwang
 * @date 2025/10/15 18:27
 */
suspend fun fetchUser() = withContext(Dispatchers.IO) {
    delay(1000)
    " User"
}

suspend fun fetchPosts() = withContext(Dispatchers.IO) {
    delay(800)
    " Posts"
}

fun main() = runBlocking {
    launch {
        println("データ取得開始")

        val userDeferred = async { fetchUser() }
        val postsDeferred = async { fetchPosts() }

        val result = "${userDeferred.await()} + ${postsDeferred.await()}"
        println("結果: $result")

        println("完了しました")
    }

    println("")
}