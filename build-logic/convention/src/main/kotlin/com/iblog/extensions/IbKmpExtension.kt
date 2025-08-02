package com.iblog.extensions

import org.gradle.api.Project

/**
 * @author junwang
 * @date 2025/08/02 22:35
 * Optional behavior configuration for KmpConventionPlugin
 */
open class IbKmpExtension {
    var namespace: String = "com.example"
    var enableRetrofit: Boolean = true
    var enableKtor: Boolean = true
    val commonMainProjectDependencies = mutableListOf<String>()
    
}