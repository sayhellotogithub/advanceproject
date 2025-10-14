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
includeWithExpose(":feature:photo")
include(":feature:features_2025")
includeWithExpose(":feature:features_2025")
include(":feature:rxjavatest")
include(":feature:explore_ar")
includeWithExpose(":feature:explore_ar")
include(":feature:pano")

//include(":core:model")
include(":domain")
include(":data")
include(":infrastructure")
include(":infrastructure-core")

include(":core:utils")
include(":core:model")
include(":core:ui")


include(":network:networkcore")
include(":network:retrofit")
include(":network:ktor")
include(":network:i18n")
include(":network:error")

include(":lab:coroutines-lab")
include(":lab:test-lab")
include(":lab:mvp:mvp")
include(":lab:mvp:mvptest")


