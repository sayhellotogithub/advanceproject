package com.iblogstreet.network.retrofit

import okhttp3.logging.HttpLoggingInterceptor

/**
 * @author junwang
 * @date 2025/07/30 16:49
 */
object LoggingInterceptorProvider {
    fun get(debug: Boolean = false): HttpLoggingInterceptor {
        return HttpLoggingInterceptor().apply {
            level =
                if (debug) HttpLoggingInterceptor.Level.BODY else HttpLoggingInterceptor.Level.NONE
        }
    }
}