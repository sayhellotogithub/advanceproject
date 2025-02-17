pluginManagement {

    repositories {
        includeBuild("build-logic")
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
        maven { url = uri("https://jitpack.io") }
    }
}

enableFeaturePreview("TYPESAFE_PROJECT_ACCESSORS")

apply(from = "$rootDir/gradle/expose/expose.gradle.kts")
val includeWithExpose: (projectPaths: String) -> Unit by extra
val includeWithJavaExpose: (projectPaths: String) -> Unit by extra

rootProject.name = "advance"
include(":app")
includeWithExpose(":feature:login")
include(":common:net:rxjava")
includeWithExpose(":feature:photo")

include(":core:designsystem")

include(":common:util")
include(":common:mvp")
include(":feature:rxjavatest")
include(":common:mvptest")
