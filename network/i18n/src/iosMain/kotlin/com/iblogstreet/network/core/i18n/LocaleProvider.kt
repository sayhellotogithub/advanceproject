package com.iblogstreet.network.core.i18n

import platform.Foundation.preferredLanguages

actual object LocaleProvider {
    actual fun current(): String {
        val languages = preferredLanguages
        return if (languages.isNotEmpty()) {
            val locale = languages.first().toString()
            locale.substring(0, 2)
        } else {
            "en"
        }
    }
}
