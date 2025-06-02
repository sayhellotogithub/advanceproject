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
    implementation(projects.core.designsystem)
    implementation(libs.androidx.appcompat)
    // ARCore & Sceneform
    implementation(libs.com.google.core.arcore)
    implementation(libs.io.github.sceneview.arsceneview)
//    implementation(libs.com.google.android.filament.filament.android)
    //filament-gltfio-android
//    implementation(libs.com.google.android.filament.gltfio.android)
//    implementation(libs.com.google.android.filament.utils.android)
//    implementation(libs.play.services.wearable)

    testImplementation(libs.bundles.androidx.testing)
    androidTestImplementation(libs.bundles.androidx.compose.ui.test)
}

