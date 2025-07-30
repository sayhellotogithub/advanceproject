package com.iblogstreet.network.core.i18n

import okhttp3.Interceptor
import okhttp3.Response

class AcceptLanguageInterceptor : Interceptor {
    override fun intercept(chain: Interceptor.Chain): Response {
        val request = chain.request().newBuilder()
            .addHeader("Accept-Language", LocaleConfig.currentLanguage.toHeader())
            .build()
        return chain.proceed(request)
    }
}

fun Language.toHeader(): String = when (this) {
    Language.ZH -> "zh-CN"
    Language.JA -> "ja-JP"
    else -> "en-US"
}