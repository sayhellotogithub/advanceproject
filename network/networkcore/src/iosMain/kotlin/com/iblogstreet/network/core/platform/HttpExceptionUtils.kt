package com.iblogstreet.network.core.platform

actual fun isHttpException(e: Throwable): Boolean = false

actual fun extractHttpError(e: Throwable): Pair<Int, String> = 0 to "Unknown"