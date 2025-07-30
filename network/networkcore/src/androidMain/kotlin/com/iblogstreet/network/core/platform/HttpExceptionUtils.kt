// androidMain
package com.iblogstreet.network.core.platform

import retrofit2.HttpException

actual fun isHttpException(e: Throwable): Boolean = e is HttpException

actual fun extractHttpError(e: Throwable): Pair<Int, String> {
    val ex = e as HttpException
    return ex.code() to ex.message()
}
