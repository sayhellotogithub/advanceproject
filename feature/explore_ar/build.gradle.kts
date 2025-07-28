plugins {
    alias(libs.plugins.iblog.android.feature)
    alias(libs.plugins.iblog.android.library.jacoco)
    alias(libs.plugins.iblog.android.library.compose)
    alias(libs.plugins.iblog.hilt)
}

android {
    namespace = "com.iblogstreet.explore_ar"
}

dependencies {
    implementation(projects.core.ui)
    implementation(libs.androidx.appcompat)
    // ARCore & Sceneform
    implementation(libs.com.google.core.arcore)
    implementation(libs.io.github.sceneview.arsceneview)
    testImplementation(libs.bundles.androidx.testing)
    androidTestImplementation(libs.bundles.androidx.compose.ui.test)
}

