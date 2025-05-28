plugins {
    alias(libs.plugins.iblog.android.feature)
    alias(libs.plugins.iblog.android.library.jacoco)
    alias(libs.plugins.iblog.android.library.compose)
    alias(libs.plugins.iblog.hilt)
}

android {
    namespace = "com.iblogstreet.features_2025"
}

dependencies {
    implementation(projects.core.designsystem)
    implementation(libs.androidx.appcompat)
    testImplementation(libs.bundles.androidx.testing)

    androidTestImplementation(libs.bundles.androidx.compose.ui.test)
}