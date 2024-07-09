import com.android.build.gradle.LibraryExtension
import com.iblogstreet.dependency.AndroidConfig
import com.iblogstreet.dependency.extensions.configureFlavors
import com.iblogstreet.dependency.extensions.configureKotlinAndroid
import com.iblogstreet.dependency.utils.BuildPlugins

import org.gradle.api.Plugin
import org.gradle.api.Project
import org.gradle.api.artifacts.VersionCatalogsExtension
import org.gradle.kotlin.dsl.configure
import org.gradle.kotlin.dsl.getByType

/**
 * @author junwang
 * @date 2024/07/09 22:58
 */
class AndroidLibraryConventionPlugin : Plugin<Project> {
    override fun apply(target: Project) {
        with(target) {
            with(pluginManager) {
                apply(BuildPlugins.ANDROID_LIBRARY)
                apply(BuildPlugins.KOTLIN_ANDROID)
            }
            extensions.configure<LibraryExtension> {
                configureKotlinAndroid(this)
                defaultConfig.targetSdk = AndroidConfig.TARGET_SDK
                configureFlavors(this)
//                configureGradleManagedDevices(this)
                packaging {
                    resources.excludes.add("META-INF/LICENSE.md")
                    resources.excludes.add("META-INF/LICENSE-notice.md")
                }
            }
//            val libs = extensions.getByType<VersionCatalogsExtension>().named("libs")
//            configurations.configureEach {
//                resolutionStrategy {
//                    force(libs.findLibrary("junit.test").get())
//                }
//            }
//            dependencies {
//                add("testImplementation", kotlin("test"))
//                add("testImplementation", project(":core:testing"))
//                add("androidTestImplementation", kotlin("test"))
//                add("androidTestImplementation", project(":core:testing"))
//                add("detektPlugins", libs.findBundle("detekt").get())
//            }
//            kotlin {
//                jvmToolchain(JDK_VERSION)
//            }
        }
    }
}