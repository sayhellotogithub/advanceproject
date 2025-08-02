package com.iblog.extensions

/**
 * @author junwang
 * @date 2025/08/02 0:54
 */
import org.gradle.api.provider.Provider

//Extension: Convert string Gradle properties to Boolean values and return true only when true
fun Provider<String>.onlyIfTrue(): Provider<Boolean> =
    map { it.toBooleanStrictOrNull() == true }
