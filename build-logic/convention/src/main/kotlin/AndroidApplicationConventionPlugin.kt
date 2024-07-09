import org.gradle.api.Plugin
import org.gradle.api.Project
import com.android.build.api.dsl.ApplicationExtension
import com.iblogstreet.dependency.AndroidConfig
import com.iblogstreet.dependency.BuildTypeDebug
import com.iblogstreet.dependency.BuildTypeRelease
import com.iblogstreet.dependency.extensions.configureFlavors
import com.iblogstreet.dependency.extensions.configureKotlinAndroid
import com.iblogstreet.dependency.utils.BuildPlugins
import org.gradle.kotlin.dsl.configure

class AndroidApplicationConventionPlugin:Plugin<Project>{
    override fun apply(target: Project) {
        with(target){
            with(pluginManager){
                apply(BuildPlugins.ANDROID_APPLICATION)
                apply(BuildPlugins.KOTLIN_ANDROID)
            }
            extensions.configure<ApplicationExtension> {
                configureKotlinAndroid(this)
                configureFlavors(this)
                defaultConfig.applicationId = AndroidConfig.APP_ID
                defaultConfig.targetSdk = AndroidConfig.TARGET_SDK
                defaultConfig.versionCode = AndroidConfig.VERSION_CODE
                defaultConfig.versionName = AndroidConfig.VERSION_NAME
                buildTypes {
                    BuildTypeDebug.create(this, signingConfigs)
                    BuildTypeRelease.create(this, signingConfigs)
//                    BuildTypeBenchmark.create(this, signingConfigs)
                }
                packaging {
                    resources.excludes.add("META-INF/AL2.0")
                    resources.excludes.add("META-INF/LGPL2.1")
                    resources.excludes.add("META-INF/LICENSE.md")
                    resources.excludes.add("META-INF/LICENSE-notice.md")
                }
                namespace = AndroidConfig.NAMESPACE

            }
        }
    }

}