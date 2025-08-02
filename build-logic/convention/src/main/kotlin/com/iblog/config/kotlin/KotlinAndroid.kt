/*
 * Copyright 2022 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.iblog.config.kotlin

import com.android.build.api.dsl.CommonExtension
import com.iblog.extensions.libs
import com.iblog.config.BuildConstants
import org.gradle.api.Project
import org.gradle.api.plugins.JavaPluginExtension
import org.gradle.kotlin.dsl.assign
import org.gradle.kotlin.dsl.configure
import org.gradle.kotlin.dsl.dependencies
import org.gradle.kotlin.dsl.provideDelegate
import org.jetbrains.kotlin.gradle.dsl.KotlinAndroidProjectExtension
import org.jetbrains.kotlin.gradle.dsl.KotlinBaseExtension
import org.jetbrains.kotlin.gradle.dsl.KotlinJvmProjectExtension

/**
 * Configure base Kotlin with Android options
 */
internal fun Project.configureKotlinAndroid(
    commonExtension: CommonExtension<*, *, *, *, *, *>,
) {
    commonExtension.apply {
        compileSdk = com.iblog.config.BuildConstants.compileSdk

        defaultConfig {
            minSdk = com.iblog.config.BuildConstants.minSdk
        }

        compileOptions {
            // Up to Java 11 APIs are available through desugaring
            sourceCompatibility = com.iblog.config.BuildConstants.javaVersion
            targetCompatibility = com.iblog.config.BuildConstants.javaVersion
            isCoreLibraryDesugaringEnabled = true
        }
    }

    configureKotlin<KotlinAndroidProjectExtension>()

    dependencies {
        add("coreLibraryDesugaring", libs.findLibrary("android.desugarJdkLibs").get())
    }
}

/**
 * Configure base Kotlin options for JVM (non-Android)
 */
internal fun Project.configureKotlinJvm() {
    extensions.configure<JavaPluginExtension> {
        sourceCompatibility = com.iblog.config.BuildConstants.javaVersion
        targetCompatibility = com.iblog.config.BuildConstants.javaVersion
    }

    configureKotlin<KotlinJvmProjectExtension>()
}

private inline fun <reified T : KotlinBaseExtension> Project.configureKotlin() = configure<T> {
    val warningsAsErrors: String? by project
    (this as? KotlinAndroidProjectExtension)?.compilerOptions?.apply {
        jvmTarget = com.iblog.config.BuildConstants.jvmTarget
        allWarningsAsErrors = warningsAsErrors.toBoolean()
        freeCompilerArgs.add("-opt-in=kotlinx.coroutines.ExperimentalCoroutinesApi")
    }
    (this as? KotlinJvmProjectExtension)?.compilerOptions?.apply {
        jvmTarget = com.iblog.config.BuildConstants.jvmTarget
        allWarningsAsErrors = warningsAsErrors.toBoolean()
        freeCompilerArgs.add("-opt-in=kotlinx.coroutines.ExperimentalCoroutinesApi")
    }
}
