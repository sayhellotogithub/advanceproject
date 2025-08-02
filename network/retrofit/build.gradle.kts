plugins {
    alias(libs.plugins.android.library)
    kotlin("android")
}

dependencies {
    implementation(projects.network.networkcore)
    implementation(projects.network.i18n)
    implementation(projects.network.error)
    implementation(libs.retrofit)
    implementation(libs.retrofit.converter.gson)
    implementation(libs.okhttp)
    implementation(libs.okhttp.logging)
}
android {
    namespace = "com.iblogstreet.network.retrofit"

}