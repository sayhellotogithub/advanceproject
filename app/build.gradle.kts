
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

    implementation(projects.core.designsystem)
    implementation(projects.feature.photo)
    implementation(projects.feature.login)
    implementation(projects.common.util)

    implementation(libs.androidx.activity.compose)
    implementation(libs.androidx.compose.material3.adaptive)
    implementation(libs.androidx.compose.material3.adaptive.layout)
    implementation(libs.androidx.compose.material3.adaptive.navigation)
    implementation(libs.androidx.compose.material3.windowSizeClass)
    implementation(libs.androidx.compose.runtime.tracing)
    implementation(libs.androidx.core.ktx)
//    implementation(libs.androidx.core.splashscreen)
    implementation(libs.androidx.hilt.navigation.compose)
    implementation(libs.androidx.lifecycle.runtimeCompose)
    implementation(libs.androidx.navigation.compose)
    implementation(libs.androidx.profileinstaller)
    implementation(libs.androidx.tracing.ktx)
    implementation(libs.androidx.window.core)
    implementation(libs.kotlinx.coroutines.guava)
    implementation(libs.coil.kt)

    ksp(libs.hilt.compiler)

//    debugImplementation(libs.androidx.compose.ui.testManifest)
////    debugImplementation(projects.uiTestHiltManifest)
//
//    kspTest(libs.hilt.compiler)
//
//    testImplementation(projects.core.dataTest)
//    testImplementation(libs.hilt.android.testing)
////    testImplementation(projects.sync.syncTest)
////
////    testDemoImplementation(libs.robolectric)
////    testDemoImplementation(libs.roborazzi)
////    testDemoImplementation(projects.core.screenshotTesting)
//
//    androidTestImplementation(kotlin("test"))
////    androidTestImplementation(projects.core.testing)
////    androidTestImplementation(projects.core.dataTest)
////    androidTestImplementation(projects.core.datastoreTest)
//    androidTestImplementation(libs.androidx.test.espresso.core)
//    androidTestImplementation(libs.androidx.navigation.testing)
//    androidTestImplementation(libs.androidx.compose.ui.test)
//    androidTestImplementation(libs.hilt.android.testing)

//    baselineProfile(projects.benchmarks)
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
