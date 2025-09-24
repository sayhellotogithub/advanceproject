package com.iblogstreet.test_lab.data

/**
 * @author junwang
 * @date 2025/09/24 15:12
 */
interface RemoteDataSource {
    suspend fun couponPercent(code: String?): Int
}