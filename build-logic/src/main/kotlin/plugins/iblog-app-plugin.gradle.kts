import config.ConfigurationKeys
import ext.configureBuildFeatures
import ext.configureBuildTypes
import ext.configureCompileOptions
import ext.configureDefaultConfig
import ext.configureSigning
import ext.configureTestOptions

plugins {
    id("com.android.application")
    id("kotlin-android")
}

android {
    compileSdk = ConfigurationKeys.sdkConfiguration.compileSdk
    namespace = ConfigurationKeys.APPLICATION_NAME

    defaultConfig {
        applicationId = ConfigurationKeys.APPLICATION_ID
    }

    configureDefaultConfig()
    configureCompileOptions()
    configureTestOptions()
    configureSigning()
    configureBuildTypes()
    configureBuildFeatures()
    composeOptions {
        kotlinCompilerExtensionVersion = "1.5.3"
    }
    kotlinOptions {
        jvmTarget = "17"
    }
}

//kotlin {
////    configurePlatformTargets()
//}
