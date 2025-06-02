package com.google.samples.apps.nowinandroid

import org.gradle.api.JavaVersion
import org.jetbrains.kotlin.gradle.dsl.JvmTarget

/**
 * @author junwang
 * @date 2025/05/27 1:27
 */
object ConstField {
    const val compileSdk = 35
    const val minSdk = 24
    const val targetSdk = 35
    val jvmTarget = JvmTarget.JVM_11
    val javaVersion = JavaVersion.VERSION_11

}
