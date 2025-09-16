package com.iblogstreet.test_lab.data

/**
 * @author junwang
 * @date 2025/09/16 15:28
 */
interface UserRepository {
    suspend fun fetch(): String
}
