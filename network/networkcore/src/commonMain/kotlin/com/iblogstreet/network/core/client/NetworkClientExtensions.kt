package com.iblogstreet.network.core.client

import com.iblogstreet.network.core.model.ApiResult

/**
 * @author junwang
 * @date 2025/07/30 18:06
 */
suspend inline fun <reified T : Any> INetworkClient.getReified(path: String): ApiResult<T> {
    return this.get(path)
}

suspend inline fun <reified R : Any, reified T : Any> INetworkClient.postReified(
    path: String,
    body: T
): ApiResult<R> {
    return this.post(path, body)
}