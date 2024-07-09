plugins {
    `kotlin-dsl`
}

group = "com.iblogstreet.buildlogic"

java {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
}


dependencies {

    implementation(libs.android.gradle.plugin)
    implementation(libs.kotlin.plugin)
}

gradlePlugin {
    plugins {
        register("androidApplication") {
            id = "iblogstreet.android.application"
            implementationClass = "AndroidApplicationConventionPlugin"
        }

        register("androidLibrary") {
            id = "iblogstreet.android.library"
            implementationClass = "AndroidLibraryConventionPlugin"
        }
    }
}
