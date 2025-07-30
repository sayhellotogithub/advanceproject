package com.iblogstreet.network.core.client

import com.iblogstreet.network.core.model.ApiResult

/**
 * @author junwang
 * @date 2025/07/29 22:10
 */
interface INetworkClient {
    suspend fun <T : Any> get(path: String): ApiResult<T>
    suspend fun <T : Any, R : Any> post(path: String, body: T): ApiResult<R>
}