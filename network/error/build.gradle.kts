plugins {
    alias(libs.plugins.iblog.kotlin.multiplatform)
}

ibKmp{
    namespace = "com.iblog.network.error" // ← 替换成你的实际包名
    enableKtor = true
    enableRetrofit = true
    commonMainProjectDependencies += ":network:networkcore"
    commonMainProjectDependencies += ":network:i18n"

}
//kotlin {
//    androidTarget()
//    applyDefaultHierarchyTemplate()
//    iosX64()
//    iosArm64()
//    iosSimulatorArm64()
//
//    sourceSets {
//        val commonMain by getting {
//            dependencies {
//                implementation(libs.kotlinx.serialization.json)
//                implementation(libs.ktor.client.core)
//                implementation(projects.network.i18n)
//                implementation(projects.network.networkcore)
//            }
//        }
//        val androidMain by getting {
//            dependencies {
//                implementation(libs.retrofit)
//                implementation(libs.okhttp)
//            }
//        }
//        val iosMain by getting {
//            dependencies {
//                implementation(libs.ktor.client.darwin)
//            }
//        }
//    }
//}
