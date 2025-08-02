import org.jetbrains.kotlin.gradle.dsl.JvmTarget

plugins {
    `kotlin-dsl`
}
java {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
}

kotlin {
    compilerOptions {
        jvmTarget = JvmTarget.JVM_17
    }
}
tasks {
    validatePlugins {
        enableStricterValidation = true
        failOnWarning = true
    }
}

dependencies {
    compileOnly(libs.android.gradlePlugin)
    compileOnly(libs.android.tools.common)
    compileOnly(libs.compose.gradlePlugin)
    compileOnly(libs.firebase.crashlytics.gradlePlugin)
    compileOnly(libs.firebase.performance.gradlePlugin)
    compileOnly(libs.kotlin.gradlePlugin)
    compileOnly(libs.ksp.gradlePlugin)
    compileOnly(libs.room.gradlePlugin)

    implementation(libs.truth)
}

gradlePlugin {
    plugins {
        register("kotlinMultiplatform"){
            id = "iblog.kotlin.multiplatform"
            implementationClass = "com.iblog.plugins.KmpConventionPlugin"
        }
        register("androidApplicationCompose") {
            id = "iblog.android.application.compose"
            implementationClass = "com.iblog.plugins.AndroidApplicationComposeConventionPlugin"
        }
        register("androidApplication") {
            id = "iblog.android.application"
            implementationClass = "com.iblog.plugins.AndroidApplicationConventionPlugin"
        }
        register("androidApplicationJacoco") {
            id = "iblog.android.application.jacoco"
            implementationClass = "com.iblog.plugins.AndroidApplicationJacocoConventionPlugin"
        }
        register("androidLibraryCompose") {
            id = "iblog.android.library.compose"
            implementationClass = "com.iblog.plugins.AndroidLibraryComposeConventionPlugin"
        }
        register("androidLibrary") {
            id = "iblog.android.library"
            implementationClass = "com.iblog.plugins.AndroidLibraryConventionPlugin"
        }
        register("androidFeature") {
            id = "iblog.android.feature"
            implementationClass = "com.iblog.plugins.AndroidFeatureConventionPlugin"
        }
        register("androidLibraryJacoco") {
            id = "iblog.android.library.jacoco"
            implementationClass = "com.iblog.plugins.AndroidLibraryJacocoConventionPlugin"
        }
        register("androidTest") {
            id = "iblog.android.test"
            implementationClass = "com.iblog.plugins.AndroidTestConventionPlugin"
        }
        register("hilt") {
            id = "iblog.hilt"
            implementationClass = "com.iblog.plugins.HiltConventionPlugin"
        }
        register("androidRoom") {
            id = "iblog.android.room"
            implementationClass = "com.iblog.plugins.AndroidRoomConventionPlugin"
        }
        register("androidFirebase") {
            id = "iblog.android.application.firebase"
            implementationClass = "com.iblog.plugins.AndroidApplicationFirebaseConventionPlugin"
        }
        register("androidFlavors") {
            id = "iblog.android.application.flavors"
            implementationClass = "com.iblog.plugins.AndroidApplicationFlavorsConventionPlugin"
        }
        register("androidLint") {
            id = "iblog.android.lint"
            implementationClass = "com.iblog.plugins.AndroidLintConventionPlugin"
        }
        register("jvmLibrary") {
            id = "iblog.jvm.library"
            implementationClass = "com.iblog.plugins.JvmLibraryConventionPlugin"
        }

    }
}
