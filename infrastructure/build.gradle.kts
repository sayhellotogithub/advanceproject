plugins {
    alias(libs.plugins.iblog.android.library)
    alias(libs.plugins.iblog.android.library.jacoco)
    alias(libs.plugins.iblog.hilt)
}

android {
    namespace = "com.iblogstreet.infrastructure"
}

dependencies {
    implementation(libs.androidx.core.ktx)
    implementation(libs.androidx.appcompat)
    implementation(libs.androidx.security.crypto)
    implementation(libs.sqlite)
    implementation(libs.sqlite.framework)
    implementation(libs.material)
    implementation(projects.infrastructureCore)
    testImplementation(libs.junit)
    androidTestImplementation(libs.androidx.junit)
    androidTestImplementation(libs.androidx.test.espresso.core)
}