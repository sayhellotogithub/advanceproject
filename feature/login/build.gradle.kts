plugins {
    alias(libs.plugins.iblog.android.feature)
    alias(libs.plugins.iblog.android.library.jacoco)
    alias(libs.plugins.iblog.android.library.compose)
    alias(libs.plugins.iblog.hilt)
}

android {
    namespace = "com.iblogstreet.login"
}

dependencies {
    implementation(libs.androidx.appcompat)
    compileOnly(projects.feature.photoExpose)
//    testImplementation(projects.core.testing)


    androidTestImplementation(libs.bundles.androidx.compose.ui.test)
}