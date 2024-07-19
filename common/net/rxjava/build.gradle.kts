
plugins {
    alias(libs.plugins.iblog.android.library)
}

android {
    namespace = "com.iblogstreet.rxjava"

}

dependencies {

    implementation(libs.androidx.core.ktx)
    implementation(libs.bundles.rxjava3)
    testImplementation(libs.androidx.compose.ui.test)
    testImplementation(libs.androidx.compose.ui.testManifest)


    testImplementation(libs.hilt.android.testing)
    testImplementation(libs.robolectric)

    androidTestImplementation(libs.bundles.androidx.compose.ui.test)
}