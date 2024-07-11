plugins {
    id("iblog-app-plugin")
}

android {
    namespace = "com.iblogstreet.advanceproject"
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
//    api("module:login")
    implementation(":feature:photo")


    debugImplementation(libs.bundles.compose.debug)
}