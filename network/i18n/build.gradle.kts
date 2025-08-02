plugins {
    alias(libs.plugins.kotlin.multiplatform)
    alias(libs.plugins.android.library)
}
android {
    namespace = "com.iblog.network.core.il18n" // ← 替换成你的实际包名
    compileSdk = 35

//    defaultConfig {
//        minSdk = 21
//    }

//    compileOptions {
//        sourceCompatibility = JavaVersion.VERSION_11
//        targetCompatibility = JavaVersion.VERSION_11
//    }
}

kotlin {
    androidTarget()
    applyDefaultHierarchyTemplate()
    iosX64()
    iosArm64()
    iosSimulatorArm64()

    sourceSets {
        val commonMain by getting {
            dependencies {
                implementation(libs.kotlinx.serialization.json)
                implementation(libs.ktor.client.core)
            }
        }
        val androidMain by getting {
            dependencies {
                implementation(libs.retrofit)
                implementation(libs.okhttp)
            }
        }
        val iosMain by getting {
            dependencies {
                implementation(libs.ktor.client.darwin)
            }
        }
    }
}
