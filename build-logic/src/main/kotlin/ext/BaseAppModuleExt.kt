package ext

import com.android.build.gradle.internal.dsl.BaseAppModuleExtension
import config.EnvKeys.IBLOG_ANDROID_KEYSTORE_ALIAS
import config.EnvKeys.IBLOG_ANDROID_KEYSTORE_PASSWORD
import config.EnvKeys.IBLOG_ANDROID_KEYSTORE_PRIVATE_KEY_PASSWORD
import java.io.File

internal fun BaseAppModuleExtension.configureSigning() {
    signingConfigs {
        create("release") {
            keyAlias = System.getenv(IBLOG_ANDROID_KEYSTORE_ALIAS)
            keyPassword = System.getenv(IBLOG_ANDROID_KEYSTORE_PRIVATE_KEY_PASSWORD)

            val path = System.getenv("HOME").plus("/moviedb-keystore")
            storeFile = File(path)
            storePassword = System.getenv(IBLOG_ANDROID_KEYSTORE_PASSWORD)
        }
    }
}

internal fun BaseAppModuleExtension.configureBuildTypes() {
    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro",
            )
            signingConfig = signingConfigs.getByName("release")
        }
    }
}
internal fun BaseAppModuleExtension.configureBuildFeatures() {
    buildFeatures {
        viewBinding = true
        compose = true
    }
}


