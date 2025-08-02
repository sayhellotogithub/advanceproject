/**
 * @author junwang
 * @date 2025/08/02 0:00
 */
package com.iblog.plugins

import com.iblog.extensions.addAllToSourceSet
import com.iblog.extensions.addToSourceSet
import org.gradle.api.Plugin
import org.gradle.api.Project
import org.gradle.kotlin.dsl.getByType
import org.jetbrains.kotlin.gradle.dsl.KotlinMultiplatformExtension

class KmpConventionPlugin : Plugin<Project> {
    override fun apply(project: Project) {
        project.pluginManager.apply("org.jetbrains.kotlin.multiplatform")
        project.pluginManager.apply("org.jetbrains.kotlin.plugin.serialization")

        val kmp = project.extensions.getByType<KotlinMultiplatformExtension>()
        kmp.apply {
            androidTarget()
            applyDefaultHierarchyTemplate()
            iosX64()
            iosArm64()
            iosSimulatorArm64()

            sourceSets.apply {
                val commonMain = getByName("commonMain")

                maybeCreate("iosMain").apply {
                    dependsOn(commonMain)
                    getByName("iosX64Main").dependsOn(this)
                    getByName("iosArm64Main").dependsOn(this)
                    getByName("iosSimulatorArm64Main").dependsOn(this)
                }
            }
        }
        project.dependencies.apply {
            addAllToSourceSet(
                "commonMain", listOf(
                    "kotlinx-coroutines-core",
                    "kotlinx-serialization-json",
                    "ktor-client-core",
                    "ktor-client-content-negotiation",
                    "ktor-serialization-kotlinx-json"
                ), project

            )
            addToSourceSet("androidMain", "ktor-client-okhttp", project)
            addToSourceSet("iosMain", "ktor-client-darwin", project)
        }

    }
}
