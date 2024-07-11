package config

import model.JavaConfiguration
import model.SdkConfiguration
import org.gradle.api.JavaVersion

internal object ConfigurationKeys {
    const val APPLICATION_ID = "com.iblogstreet.advanceproject"
    const val APPLICATION_NAME = "com.iblogstreet.advanceproject"
    const val APP_NAME = "iblog"
    const val HAS_UNIT_TESTS_DEFAULT_VALUES = true

    val javaConfiguration = JavaConfiguration(
        javaVmTarget = "17",
        version = JavaVersion.VERSION_17
    )

    val sdkConfiguration = SdkConfiguration(
        minSdk = 22,
        targetSdk = 34,
        compileSdk = 34
    )

    val ELIGIBLE_MODULES_FOR_COVERAGE = listOf(
        ModuleKeys.FEATURE_LOGIN_MODULE,
        ModuleKeys.FEATURE_PHOTO_MODULE
    )
}
