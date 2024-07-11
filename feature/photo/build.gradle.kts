@Suppress("DSL_SCOPE_VIOLATION") // TODO: Remove once KTIJ-19369 is fixed
plugins {
    id("iblog-app-plugin")
}

android {
    namespace = "com.iblogstreet.photo"


}

dependencies {
    val composeBom = platform(libs.androidx.compose.bom)
    implementation(composeBom)
    implementation(libs.bundles.androidx)
    implementation(libs.bundles.compose)
    implementation(libs.bundles.rxjava3)
    testImplementation(libs.bundles.unit.tests)
    androidTestImplementation(composeBom)
    androidTestImplementation(libs.bundles.instrumented.tests)
    debugImplementation(libs.bundles.compose.debug)
}