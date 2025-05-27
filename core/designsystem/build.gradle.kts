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

    api(platform(libs.androidx.compose.bom))
    api(libs.androidx.compose.foundation)
    api(libs.androidx.compose.foundation.layout)
    api(libs.androidx.compose.material.iconsExtended)
    api(libs.bundles.androidx.compose.material3)
    api(libs.bundles.androidx.compose.ui)
    api(libs.androidx.compose.runtime)

    implementation(libs.coil.kt.compose)

    testImplementation(libs.androidx.compose.ui.test)
    testImplementation(libs.androidx.compose.ui.testManifest)

    testImplementation(libs.hilt.android.testing)
    testImplementation(libs.robolectric)

    androidTestImplementation(libs.bundles.androidx.compose.ui.test)
}