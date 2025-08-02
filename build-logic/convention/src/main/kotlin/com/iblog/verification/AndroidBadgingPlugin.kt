package com.iblog.verification

/**
 * @author junwang
 * @date 2025/08/02 17:21
 */

import com.android.build.api.variant.ApplicationAndroidComponentsExtension
import com.android.build.gradle.BaseExtension
import org.gradle.api.Plugin
import org.gradle.api.Project
import org.gradle.kotlin.dsl.getByType

class AndroidBadgingPlugin : Plugin<Project> {
    override fun apply(project: Project) {
        val baseExtension = project.extensions.getByType<BaseExtension>()
        val componentsExtension =
            project.extensions.getByType<ApplicationAndroidComponentsExtension>()
        project.configureBadgingTasks(baseExtension, componentsExtension)
    }
}
