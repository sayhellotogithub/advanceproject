package com.iblogstreet.dependency.extensions

import org.gradle.api.JavaVersion
import org.gradle.api.Project
import org.gradle.kotlin.dsl.configure
import org.jetbrains.kotlin.gradle.dsl.JvmTarget
import org.jetbrains.kotlin.gradle.dsl.KotlinAndroidProjectExtension
import com.android.build.api.dsl.CommonExtension
import com.iblogstreet.dependency.AndroidConfig

internal fun Project.configureKotlinAndroid(
    commonExtension: CommonExtension<*, *, *, *, *>,
    optInCoroutines: Boolean = true,
) {
    commonExtension.apply {
        compileSdk = AndroidConfig.COMPILE_SDK

        defaultConfig {
            minSdk = AndroidConfig.MIN_SDK
            testInstrumentationRunner = AndroidConfig.TEST_INSTRUMENTATION_RUNNER
            vectorDrawables{
                useSupportLibrary = true
            }
        }
        compileOptions {
            sourceCompatibility = JavaVersion.VERSION_1_8
            targetCompatibility = JavaVersion.VERSION_1_8
        }

        configureKotlin(optInCoroutines)

        buildFeatures {
            viewBinding = true
            compose = true
        }


    }
}

private fun Project.configureKotlin(optInCoroutines: Boolean) {
    configure<KotlinAndroidProjectExtension> {
        compilerOptions.apply {
            jvmTarget.set(JvmTarget.JVM_1_8)
            // Treat all Kotlin warnings as errors (disabled by default)
            allWarningsAsErrors.set(true)
            freeCompilerArgs.addAll(
                listOfNotNull(
                    "-opt-in=kotlin.RequiresOptIn",
                    "-Xcontext-receivers",
                    // Enable experimental coroutines APIs, including Flow
                    "-opt-in=kotlinx.coroutines.ExperimentalCoroutinesApi".takeIf { optInCoroutines },
                    "-opt-in=kotlinx.coroutines.FlowPreview".takeIf { optInCoroutines },
                )
            )
        }
    }
}