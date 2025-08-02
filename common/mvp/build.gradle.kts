plugins {
    alias(libs.plugins.iblog.android.library)
}

android {
    namespace = "com.iblogstreet.mvp"

}

dependencies {

    implementation(libs.androidx.core.ktx)
    implementation(libs.androidx.appcompat)

    testImplementation(libs.junit)
    androidTestImplementation(libs.androidx.junit)
    androidTestImplementation(libs.androidx.test.espresso.core)
}