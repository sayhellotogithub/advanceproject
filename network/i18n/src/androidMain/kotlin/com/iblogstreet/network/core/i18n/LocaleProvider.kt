package com.iblogstreet.network.core.i18n

import java.util.*

actual object LocaleProvider {
    actual fun current(): String = Locale.getDefault().language
}
