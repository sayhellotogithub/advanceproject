package com.iblog.configure

import com.android.build.api.dsl.CommonExtension
import com.iblog.extensions.addComposeDependencies
import com.iblog.extensions.onlyIfTrue
import org.gradle.api.Project
import org.gradle.kotlin.dsl.configure
import org.gradle.kotlin.dsl.dependencies
import org.jetbrains.kotlin.compose.compiler.gradle.ComposeCompilerGradlePluginExtension

/**
 * Configure Compose-specific options
 */
internal fun Project.configureAndroidCompose(
    commonExtension: CommonExtension<*, *, *, *, *, *>,
) {
    commonExtension.apply {
        buildFeatures {
            compose = true
        }

        dependencies {
            addComposeDependencies(project)
        }

        testOptions {
            unitTests.isIncludeAndroidResources = true
        }
    }
    configureComposeCompiler()
}

private fun Project.configureComposeCompiler() {
    extensions.configure<ComposeCompilerGradlePluginExtension> {
        with(project) {
            providers.gradleProperty("enableComposeCompilerMetrics")
                .onlyIfTrue()
                .map {
                    project.rootProject.layout.buildDirectory.dir("compose-metrics").get().asFile
                }
                .orNull
                ?.let(metricsDestination::set)

            providers.gradleProperty("enableComposeCompilerReports")
                .onlyIfTrue()
                .map { rootProject.layout.buildDirectory.dir("compose-reports").get().asFile }
                .orNull
                .let(reportsDestination::set)

        }
        stabilityConfigurationFiles.set(
            listOf(rootProject.layout.projectDirectory.file("compose_compiler_config.conf"))
        )
    }
}

