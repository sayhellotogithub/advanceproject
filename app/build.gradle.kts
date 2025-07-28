plugins {
    alias(libs.plugins.iblog.android.application)
    alias(libs.plugins.iblog.android.application.compose)
    alias(libs.plugins.iblog.android.application.flavors)
    alias(libs.plugins.iblog.android.application.jacoco)
    alias(libs.plugins.iblog.hilt)
}

android {
    namespace = "com.iblogstreet.advance"
    defaultConfig {
        applicationId = "com.iblogstreet.advance"
        versionCode = 1
        versionName = "0.0.1"

        // Custom test runner to set up Hilt dependency graph
        vectorDrawables {
            useSupportLibrary = true
        }
    }

    packaging {
        resources {
            excludes.add("/META-INF/{AL2.0,LGPL2.1}")
        }
    }
    testOptions {
        unitTests {
            isIncludeAndroidResources = true
        }
    }

}

dependencies {
    implementation(platform(libs.androidx.compose.bom))
    implementation(projects.core.ui)
    implementation(projects.feature.login)
    implementation(projects.feature.photo)
    implementation(projects.feature.features2025)
    implementation(projects.feature.exploreAr)

    implementation(libs.kotlin.logging)
    implementation(libs.org.slf4j.simple)


    implementation(libs.androidx.activity.compose)
    implementation(libs.bundles.androidx.compose.material3)

    implementation(libs.androidx.compose.runtime.tracing)
    implementation(libs.androidx.core.ktx)
    implementation(libs.androidx.hilt.navigation.compose)
    implementation(libs.androidx.lifecycle.runtimeCompose)
    implementation(libs.androidx.navigation.compose)
    implementation(libs.androidx.profileinstaller)
    implementation(libs.androidx.tracing.ktx)
    implementation(libs.androidx.window.core)
    implementation(libs.kotlinx.coroutines.guava)
    implementation(libs.coil.kt)

    ksp(libs.hilt.compiler)
    implementation(libs.androidx.security.crypto)


    androidTestImplementation(libs.androidx.compose.ui.test)
    androidTestImplementation(libs.hilt.android.testing)
    testImplementation(libs.junit)
}
//
//baselineProfile {
//    // Don't build on every iteration of a full assemble.
//    // Instead enable generation directly for the release build variant.
//    automaticGenerationDuringBuild = false
//}

//dependencyGuard {
//    configuration("prodReleaseRuntimeClasspath")
//}
