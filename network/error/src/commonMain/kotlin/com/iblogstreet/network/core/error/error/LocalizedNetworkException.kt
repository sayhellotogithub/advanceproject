package com.iblogstreet.network.core.error.error

import com.iblogstreet.network.core.i18n.Language
import com.iblogstreet.network.core.i18n.LocaleConfig
import com.iblogstreet.network.core.i18n.LocalizedMessageProvider
import com.iblogstreet.network.core.i18n.error.ErrorCode

class LocalizedNetworkException(
    val code: ErrorCode,
    val language: Language = LocaleConfig.currentLanguage,
    val extra: String? = null
) : Exception() {
    override val message: String
        get() = LocalizedMessageProvider.getMessage(code, language) + (extra?.let { " ($it)" } ?: "")
}
