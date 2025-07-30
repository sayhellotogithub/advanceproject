package com.iblogstreet.network.core.error.util

import com.iblogstreet.network.core.i18n.Language
import com.iblogstreet.network.core.i18n.LocaleConfig
import com.iblogstreet.network.core.model.ApiResult

expect suspend fun <T> safeApiCallWithLocale(
    locale: Language = LocaleConfig.currentLanguage,
    block: suspend () -> T
): ApiResult<T>
