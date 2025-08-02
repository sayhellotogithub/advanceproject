package com.iblog.plugins
import com.android.build.gradle.LibraryExtension

import org.gradle.api.Plugin
import org.gradle.api.Project
import org.gradle.kotlin.dsl.configure
import org.gradle.kotlin.dsl.dependencies
import com.iblog.extensions.addFeatureModuleDependencies

class AndroidFeatureConventionPlugin : Plugin<Project> {
    override fun apply(target: Project) {
        with(target) {
            pluginManager.apply {
                apply("iblog.android.library")
                apply("iblog.hilt")
            }

            extensions.configure<LibraryExtension> {
                testOptions.animationsDisabled = true
                com.iblog.testing.devices.configureGradleManagedDevices(this)
            }

            dependencies {
                addFeatureModuleDependencies(project)
            }
        }
    }
}