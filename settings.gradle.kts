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
include(":feature:features_2025")
includeWithExpose(":feature:features_2025")

include(":core:ui")

include(":common:mvp")
include(":feature:rxjavatest")
include(":common:mvptest")

include(":feature:explore_ar")
includeWithExpose(":feature:explore_ar")
//include(":core:model")
include(":domain")
include(":data")
include(":infrastructure")
include(":core:utils")
include(":core:model")
include(":infrastructure-core")
include(":network:networkcore")
include(":network:retrofit")
include(":network:ktor")
include(":network:i18n")
include(":network:error")

include(":core:coroutines-lab")
include(":core:test-lab")
