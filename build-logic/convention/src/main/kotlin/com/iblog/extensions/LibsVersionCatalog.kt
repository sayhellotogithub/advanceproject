/*
* dependencies {
*    implementation(libs.findLibrary("androidx.core.ktx").get())
*    implementation(libs.findLibrary("kotlinx.coroutines").get())
*}
* or
* val coroutines = libs.findLibrary("kotlinx.coroutines").get()
 */

package com.iblog.extensions

import org.gradle.api.Project
import org.gradle.api.artifacts.MinimalExternalModuleDependency
import org.gradle.api.artifacts.VersionCatalog
import org.gradle.api.artifacts.VersionCatalogsExtension
import org.gradle.kotlin.dsl.getByType
import org.gradle.kotlin.dsl.provideDelegate
import org.gradle.api.provider.Provider

val Project.libs
    get(): VersionCatalog = extensions.getByType<VersionCatalogsExtension>().named("libs")

fun VersionCatalog.library(alias: String): Provider<MinimalExternalModuleDependency> =
    findLibrary(alias).orElseThrow {
        IllegalArgumentException("Library alias '$alias' not found in libs.versions.toml")
    }