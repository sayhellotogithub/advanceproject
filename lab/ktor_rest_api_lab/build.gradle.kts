plugins {
    alias(libs.plugins.kotlin.jvm) apply false
    alias(libs.plugins.ktor) apply false
    alias(libs.plugins.sqldelight) apply false
    alias(libs.plugins.kotlin.serialization) apply false
}

allprojects {
    group = "com.iblogstreet"
    version = "0.1.0"

    tasks.withType<JavaCompile>().configureEach {
        sourceCompatibility = "17"
        targetCompatibility = "17"
    }
    extensions.findByType(org.jetbrains.kotlin.gradle.dsl.KotlinJvmProjectExtension::class.java)?.apply {
        jvmToolchain(17)
    }
}
