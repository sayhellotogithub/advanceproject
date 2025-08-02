plugins {
    alias(libs.plugins.iblog.android.application)
    alias(libs.plugins.iblog.android.application.compose)
    alias(libs.plugins.iblog.android.application.flavors)
    alias(libs.plugins.iblog.android.application.jacoco)
    alias(libs.plugins.iblog.hilt)
}

android {
    namespace = "com.iblogstreet.advance"
    defaultConfig {
        applicationId = "com.iblogstreet.advance"
        versionCode = 1
        versionName = "0.0.1"

        vectorDrawables.useSupportLibrary = true
    }

    packaging.resources.excludes += "/META-INF/{AL2.0,LGPL2.1}"

    testOptions.unitTests.isIncludeAndroidResources = true

}

dependencies {
    implementation(platform(libs.androidx.compose.bom))

    implementation(projects.core.ui)
    implementation(projects.feature.login)
    implementation(projects.feature.photo)
    implementation(projects.feature.features2025)
    implementation(projects.feature.exploreAr)
    implementation(projects.infrastructureCore)
    implementation(projects.infrastructure)
    implementation(projects.data)
    implementation(projects.domain)

    // Kotlin logging & SLF4J
    implementation(libs.kotlin.logging)
    implementation(libs.org.slf4j.simple)

    // AndroidX core
    implementation(libs.androidx.core.ktx)
    implementation(libs.androidx.window.core)
    implementation(libs.androidx.profileinstaller)

    // Compose
    implementation(libs.androidx.activity.compose)
    implementation(libs.bundles.androidx.compose.material3)
    implementation(libs.androidx.compose.runtime.tracing)
    implementation(libs.androidx.navigation.compose)

    // Hilt & DI
    implementation(libs.androidx.hilt.navigation.compose)
    ksp(libs.hilt.compiler)

    // Lifecycle & Tracing
    implementation(libs.androidx.lifecycle.runtimeCompose)
    implementation(libs.androidx.tracing.ktx)

    // Other libraries
    implementation(libs.kotlinx.coroutines.guava)
    implementation(libs.coil.kt)
    implementation(libs.androidx.security.crypto)

    // Test libraries
    testImplementation(libs.junit)
    testImplementation(libs.mockk)
    testImplementation(libs.kotlinx.coroutines.test)

    androidTestImplementation(libs.androidx.compose.ui.test)
    androidTestImplementation(libs.hilt.android.testing)
    androidTestImplementation(libs.androidx.junit)
    androidTestImplementation(libs.androidx.junit.ktx)
}

