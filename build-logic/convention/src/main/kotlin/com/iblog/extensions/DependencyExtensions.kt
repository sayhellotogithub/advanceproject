package com.iblog.extensions

/**
 * @author junwang
 * @date 2025/08/02 0:20
 */

import org.gradle.api.Project
import org.gradle.api.artifacts.MinimalExternalModuleDependency

import org.gradle.api.artifacts.VersionCatalog
import org.gradle.api.artifacts.dsl.DependencyHandler


@Suppress("UNCHECKED_CAST")
private fun Project.safeVersionCatalog(): VersionCatalog {
    return libs
}

/**
 * VersionCatalog extension to obtain library dependencies.
 */
fun Project.library(alias: String): MinimalExternalModuleDependency {
    val libs = safeVersionCatalog()
    return libs.findLibrary(alias)
        .orElseThrow { IllegalArgumentException("Library '$alias' not found in version catalog.") }
        .get()
}

/**
 * Adds dependencies to the specified Kotlin Multiplatform sourceSet.
 *  Such as commonMainImplementation, androidMainImplementation, etc.
 */
fun DependencyHandler.addToSourceSet(
    sourceSet: String,
    alias: String,
    project: Project
) {
    val configuration = "${sourceSet}Implementation"
    val libs = project.safeVersionCatalog()

    if (project.configurations.findByName(configuration) == null) {
        project.logger.warn("⚠️ Configuration '$configuration' not found. Skipping dependency for '$alias'")
        return
    }
    val dependency = libs.findLibrary(alias).orElse(null)
    if (dependency == null) {
        project.logger.warn("⚠️ Library alias '$alias' not found in version catalog. Skipping.")
        return
    }
    add(configuration, dependency)
}

/**
 * Batch add dependencies to the specified Kotlin Multiplatform sourceSet
 *dependencies {
 *addAllToSourceSet("commonMain", listOf(
 *"kotlinx-coroutines-core",
 *"ktor-client-core"
), project)
}
 */
fun DependencyHandler.addAllToSourceSet(
    sourceSet: String,
    aliases: List<String>,
    project: Project
) {
    aliases.forEach { addToSourceSet(sourceSet, it, project) }
}

/**
 *Add common dependencies (applicable to configurations such as implementation/debugImplementation).
 */
fun DependencyHandler.addFromCatalog(
    alias: String,
    configuration: String,
    project: Project
) {
    add(configuration, project.library(alias))
}

/**
 * Add common dependencies in batches.
 */
fun DependencyHandler.addAllFromCatalog(
    entries: List<Pair<String, String>>,
    project: Project
) {
    entries.forEach { (alias, configuration) ->
        add(configuration, project.library(alias))
    }
}

/**
 * Add platform() BOM dependency.
 */
fun DependencyHandler.addPlatformFromCatalog(
    alias: String,
    configurations: List<String>,
    project: Project
) {
//    val libs = project.libsCatalog()

//    val bom = libs.findLibrary(alias)
//        .orElseThrow { IllegalArgumentException("BOM '$alias' not found in version catalog.") }
//        .get()
//    val bom = libs.findLibrary(alias)
    val bom = project.safeVersionCatalog()
        .findLibrary(alias)
        .orElseThrow { IllegalArgumentException("BOM '$alias' not found in version catalog.") }
        .get()
    configurations.forEach { config ->
        add(config, platform(bom))
    }
}

/**
 * Utility: Add a library as a platform() dependency to a single configuration
 */
fun DependencyHandler.addSinglePlatformFromCatalog(
    alias: String,
    configuration: String,
    project: Project
) {
    val bom = project.safeVersionCatalog()
        .findLibrary(alias)
        .orElseThrow { IllegalArgumentException("BOM '$alias' not found in version catalog.") }
        .get()
    add(configuration, platform(bom))
}

/**
 * DSL helper: Enhance DSL readability with block-style syntax for KMP source sets
 */
fun DependencyHandler.kmpSourceSet(
    sourceSet: String,
    project: Project,
    block: DependencyHandlerScope.() -> Unit
) {
    DependencyHandlerScope(this, project, sourceSet).block()
}


class DependencyHandlerScope(
    private val handler: DependencyHandler,
    private val project: Project,
    private val sourceSet: String
) {
    fun implementation(alias: String) =
        handler.add("${sourceSet}Implementation", project.library(alias))

    fun api(alias: String) = handler.add("${sourceSet}Api", project.library(alias))
    fun compileOnly(alias: String) = handler.add("${sourceSet}CompileOnly", project.library(alias))
}


/**
 * Add Compose-related dependencies (including BOM and tooling)
 */
fun DependencyHandler.addComposeDependencies(project: Project) {
    addPlatformFromCatalog(
        alias = "androidx-compose-bom",
        configurations = listOf("implementation", "androidTestImplementation"),
        project = project
    )

    addAllFromCatalog(
        listOf(
            "androidx-compose-ui-tooling-preview" to "implementation",
            "androidx-compose-ui-tooling" to "debugImplementation"
        ),
        project = project
    )
}

/**
 * Add Firebase-related dependencies (including BOM, Analytics, Performance, Crashlytics)
 */
fun DependencyHandler.addFirebaseDependencies(project: Project) {
    addSinglePlatformFromCatalog(
        alias = "firebase-bom",
        configuration = "implementation",
        project = project
    )

    addAllFromCatalog(
        listOf(
            "firebase.analytics" to "implementation",
            "firebase.performance" to "implementation",
            "firebase.crashlytics" to "implementation"
        ),
        project = project
    )
}

fun DependencyHandler.addFeatureModuleDependencies(project: Project) {
//    add("implementation", project(":core:ui"))

    addAllFromCatalog(
        listOf(
            "androidx.hilt.navigation.compose" to "implementation",
            "androidx.lifecycle.runtimeCompose" to "implementation",
            "androidx.lifecycle.viewModelCompose" to "implementation",
            "androidx.tracing.ktx" to "implementation",
            "androidx.lifecycle.runtimeTesting" to "androidTestImplementation"
        ),
        project
    )
}



