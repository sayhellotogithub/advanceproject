package com.iblog.plugins/*
 * Copyright 2022 The Android Open Source Project
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *       https://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 */

import com.android.build.api.variant.LibraryAndroidComponentsExtension
import com.android.build.gradle.LibraryExtension
import com.iblog.config.BuildConstants
import com.iblog.config.kotlin.configureKotlinAndroid
import com.iblog.extensions.addFromCatalog
import com.iblog.extensions.disableUnnecessaryAndroidTests
import com.iblog.flavor.configureFlavors
import com.iblog.testing.devices.configureGradleManagedDevices
import com.iblog.utils.toResourcePrefix
import com.iblog.verification.configurePrintApksTask
import org.gradle.api.Plugin
import org.gradle.api.Project
import org.gradle.kotlin.dsl.configure
import org.gradle.kotlin.dsl.dependencies

class AndroidLibraryConventionPlugin : Plugin<Project> {
    override fun apply(target: Project) {
        with(target) {
            with(pluginManager) {
                apply("com.android.library")
                apply("org.jetbrains.kotlin.android")
                apply("iblog.android.lint")
            }

            extensions.configure<LibraryExtension> {
                configureKotlinAndroid(this)
                defaultConfig.targetSdk = BuildConstants.targetSdk
                defaultConfig.testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
                testOptions.animationsDisabled = true
                configureFlavors(this)
                configureGradleManagedDevices(this)
                resourcePrefix = path.toResourcePrefix()
            }
            extensions.configure<LibraryAndroidComponentsExtension> {
                configurePrintApksTask(this)
                disableUnnecessaryAndroidTests(this@with)
            }

            dependencies {
                add("testImplementation", "org.jetbrains.kotlin:kotlin-test")
                add("androidTestImplementation", "org.jetbrains.kotlin:kotlin-test")
                addFromCatalog("androidx.tracing.ktx", "implementation", project)
            }
        }
    }
}
