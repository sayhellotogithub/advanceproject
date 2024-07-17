plugins {

    alias(libs.plugins.iblog.android.library)
}

android {
    namespace = "com.iblogstreet.ui"

}

dependencies {

    implementation(libs.androidx.core.ktx)
    implementation(libs.appcompat)
    implementation(libs.material)
    testImplementation(libs.junit)
    androidTestImplementation(libs.androidx.junit)
    androidTestImplementation(libs.androidx.espresso.core)
}