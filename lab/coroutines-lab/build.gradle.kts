plugins {
    id("java-library")
    alias(libs.plugins.kotlin.jvm)
}
java {
    sourceCompatibility = JavaVersion.VERSION_11
    targetCompatibility = JavaVersion.VERSION_11
}
kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_11
    }
}
dependencies{
    implementation(libs.kotlin.stdlib)
    implementation(libs.kotlinx.coroutines.core)

    testImplementation(libs.kotlinx.coroutines.test)
    testImplementation(libs.kotlin.test)
    testImplementation(libs.mockk)
    testImplementation(libs.turbine)
    testImplementation(libs.junit.jupiter)

}