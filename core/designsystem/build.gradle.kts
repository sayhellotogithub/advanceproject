plugins {
    alias(libs.plugins.iblog.android.library)
    alias(libs.plugins.iblog.android.library.compose)
    alias(libs.plugins.iblog.android.library.jacoco)
    alias(libs.plugins.roborazzi)
}

android {
    namespace = "com.iblogstreet.designsyste"
    defaultConfig {
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }
}

dependencies {

    api(libs.androidx.compose.foundation)
    api(libs.androidx.compose.foundation.layout)
    api(libs.androidx.compose.material.iconsExtended)
    api(libs.androidx.compose.material3)
    api(libs.androidx.compose.material3.adaptive)
    api(libs.androidx.compose.material3.navigationSuite)
    api(libs.androidx.compose.runtime)
    api(libs.androidx.compose.ui.util)

    implementation(libs.coil.kt.compose)
    implementation(libs.androidx.core)

    testImplementation(libs.androidx.compose.ui.test)
    testImplementation(libs.androidx.compose.ui.testManifest)

    testImplementation(libs.hilt.android.testing)
    testImplementation(libs.robolectric)

    androidTestImplementation(libs.bundles.androidx.compose.ui.test)
}