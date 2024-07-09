package com.iblogstreet.dependency

/**
 * @author junwang
 * @date 2024/07/09 22:50
 */
import com.android.build.api.dsl.ApkSigningConfig
import com.android.build.api.dsl.ApplicationBuildType
import org.gradle.api.NamedDomainObjectContainer

interface BuildType<T: com.android.build.api.dsl.BuildType> {
    val name: String

    fun create(
        buildTypeNamedDomainObjectContainer: NamedDomainObjectContainer<T>,
        signingConfigDomainObjectContainer: NamedDomainObjectContainer<out ApkSigningConfig>? = null,
    ): T

    companion object {
        const val DEBUG = "debug"
        const val RELEASE = "release"
        const val BENCHMARK = "benchmark"
    }
}

object BuildTypeDebug : BuildType<ApplicationBuildType> {
    override val name = BuildType.DEBUG

    override fun create(
        buildTypeNamedDomainObjectContainer: NamedDomainObjectContainer<ApplicationBuildType>,
        signingConfigDomainObjectContainer: NamedDomainObjectContainer<out ApkSigningConfig>?,
    ): ApplicationBuildType {
        return buildTypeNamedDomainObjectContainer.getByName(name) {
            isMinifyEnabled = false
            isShrinkResources = false
            applicationIdSuffix = ".debug"
            versionNameSuffix = "-debug"
            signingConfig = signingConfigDomainObjectContainer?.getByName(BuildType.DEBUG)
        }
    }
}

object BuildTypeRelease : BuildType<ApplicationBuildType> {
    override val name = BuildType.RELEASE

    override fun create(
        buildTypeNamedDomainObjectContainer: NamedDomainObjectContainer<ApplicationBuildType>,
        signingConfigDomainObjectContainer: NamedDomainObjectContainer<out ApkSigningConfig>?,
    ): ApplicationBuildType {
        return buildTypeNamedDomainObjectContainer.getByName(name) {
            proguardFiles("proguard-android-optimize.txt", "proguard-rules.pro")
            isMinifyEnabled = true
            isShrinkResources = true
//            signingConfig = signingConfigDomainObjectContainer?.getByName(BuildType.RELEASE)
        }
    }
}

//object BuildTypeBenchmark : BuildType<ApplicationBuildType> {
//    override val name = BuildType.BENCHMARK
//
//    override fun create(
//        buildTypeNamedDomainObjectContainer: NamedDomainObjectContainer<ApplicationBuildType>,
//        signingConfigDomainObjectContainer: NamedDomainObjectContainer<out ApkSigningConfig>?,
//    ): ApplicationBuildType {
//        return buildTypeNamedDomainObjectContainer.create(name) {
//            initWith(buildTypeNamedDomainObjectContainer.getByName(BuildType.BENCHMARK))
//            signingConfig = signingConfigDomainObjectContainer?.getByName(BuildType.DEBUG)
//            matchingFallbacks.add(BuildType.BENCHMARK)
//            proguardFiles("proguard-android-optimize.txt", "proguard-rules.pro")
//        }
//    }
//}