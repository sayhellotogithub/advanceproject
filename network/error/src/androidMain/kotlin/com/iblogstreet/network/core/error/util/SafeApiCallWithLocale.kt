package com.iblogstreet.network.core.error.util

import com.iblogstreet.network.core.error.error.LocalizedNetworkException

import com.iblogstreet.network.core.i18n.Language
import com.iblogstreet.network.core.i18n.error.ErrorCode
import com.iblogstreet.network.core.model.ApiResult
import java.net.*
import retrofit2.HttpException
import kotlinx.serialization.SerializationException

actual suspend fun <T> safeApiCallWithLocale(
    locale: Language,
    block: suspend () -> T
): ApiResult<T> {
    return try {
        ApiResult.Success(block())
    } catch (e: Exception) {
        val code = when (e) {
            is SocketTimeoutException -> ErrorCode.TIMEOUT
            is UnknownHostException, is ConnectException -> ErrorCode.NO_INTERNET
            is HttpException -> ErrorCode.HTTP_ERROR
            is SerializationException -> ErrorCode.PARSE_ERROR
            is IllegalStateException -> ErrorCode.EMPTY_BODY
            else -> ErrorCode.UNKNOWN_ERROR
        }
        ApiResult.Failure(LocalizedNetworkException(code, locale, e.localizedMessage))
    }
}
