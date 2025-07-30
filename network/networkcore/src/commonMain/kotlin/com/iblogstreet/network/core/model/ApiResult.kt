package com.iblogstreet.network.core.model

sealed class ApiResult<out T> {
    data class Success<T>(val data: T) : ApiResult<T>()
    data class Failure(val error: Throwable, val message: String? = error.message) : ApiResult<Nothing>()
}
