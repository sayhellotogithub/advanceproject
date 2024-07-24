plugins {
    alias(libs.plugins.iblog.android.feature)
    alias(libs.plugins.iblog.android.library.jacoco)
    alias(libs.plugins.iblog.android.library.compose)
    alias(libs.plugins.iblog.hilt)
}

android {
    namespace = "com.iblogstreet.photo"
}

dependencies {

    implementation(libs.androidx.appcompat)
//    testImplementation(projects.core.testing)\
    implementation(libs.bundles.rxjava3)
    implementation(libs.androidx.constraintlayout)
    compileOnly(projects.feature.loginExpose)
    api(libs.kotlin.logging)



    androidTestImplementation(libs.bundles.androidx.compose.ui.test)
}