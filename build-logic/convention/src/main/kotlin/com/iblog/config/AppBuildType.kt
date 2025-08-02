package com.iblog.config

/**
 * @author junwang
 * @date 2025/08/02 17:42
 */
/**
 * This is shared between :app and :benchmarks module to provide configurations type safety.
 */
enum class AppBuildType(val applicationIdSuffix: String? = null) {
    DEBUG(".debug"),
    RELEASE,
}
