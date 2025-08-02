/**
 * @author junwang
 * @date 2025/08/02 0:00
 */
package com.iblog.plugins

import com.android.build.api.dsl.LibraryExtension
import com.iblog.extensions.IbKmpExtension
import com.iblog.extensions.library
import com.iblog.extensions.libs
import org.gradle.api.Plugin
import org.gradle.api.Project
import org.gradle.kotlin.dsl.configure
import org.gradle.kotlin.dsl.create
import org.jetbrains.kotlin.gradle.dsl.KotlinMultiplatformExtension

class KmpConventionPlugin : Plugin<Project> {
    override fun apply(project: Project) = with(project) {
        val ext = extensions.create<IbKmpExtension>("ibKmp")

        pluginManager.apply("com.android.library")
        pluginManager.apply("org.jetbrains.kotlin.multiplatform")

        extensions.configure<LibraryExtension> {
            namespace = ext.namespace
            compileSdk = 35
        }

        afterEvaluate {
            extensions.configure<KotlinMultiplatformExtension> {
                androidTarget()
                applyDefaultHierarchyTemplate()
                iosX64()
                iosArm64()
//                iosSimulatorArm64()

                ext.commonMainProjectDependencies.forEach {
                    project.dependencies.add("commonMainImplementation", project(it))
                }

                if (ext.enableKtor) {
                    project.dependencies.add(
                        "commonMainImplementation",
                        libs.library("ktor.client.core")
                    )
                    if (configurations.findByName("iosMainImplementation") != null && ext.enableKtor) {
                        dependencies.add(
                            "iosMainImplementation",
                            libs.library("ktor.client.darwin")
                        )
                    }

                }

                project.dependencies.add(
                    "commonMainImplementation",
                    libs.library("kotlinx.serialization.json")
                )

                if (ext.enableRetrofit) {
                    project.dependencies.add("androidMainImplementation", libs.library("retrofit"))
                    project.dependencies.add("androidMainImplementation", libs.library("okhttp"))
                }
            }
        }
    }
}
