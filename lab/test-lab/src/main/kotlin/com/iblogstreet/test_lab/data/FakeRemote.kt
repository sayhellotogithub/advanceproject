package com.iblogstreet.test_lab.data

import kotlinx.coroutines.delay

/**
 * @author junwang
 * @date 2025/09/24 15:20
 */
class FakeRemote : RemoteDataSource {
    override suspend fun couponPercent(code: String?): Int {
        delay(10)//Simulated Network
        return when (code) {
            "MEGA40" -> 40
            "SUMMER10" -> 10
            else -> 10
        }
    }

}