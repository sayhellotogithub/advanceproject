package com.iblog.utils

/**
 * @author junwang
 * @date 2025/08/02 17:09
 */

fun String.toResourcePrefix(): String {
    return this.split("""\W+""".toRegex()) // \W = 非単語文字
        .filter { it.isNotBlank() }
        .distinct()
        .joinToString("_")
        .lowercase() + "_"
}
