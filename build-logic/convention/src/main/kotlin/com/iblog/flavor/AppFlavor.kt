package com.iblog.flavor

/**
 * @author junwang
 * @date 2025/08/02 17:47
 * android {
 *     namespace = "com.example.app"
 *
 *     configureFlavors(this) { flavor ->
 *         when (flavor) {
 *             AppFlavor.demo -> {
 *                 versionNameSuffix = "-demo"
 *             }
 *             AppFlavor.prod -> {
 *                 // 正式版配置
 *             }
 *         }
 *     }
 * }
 *
 */
@Suppress("EnumEntryName")
enum class AppFlavor(val dimension: FlavorDimension, val applicationIdSuffix: String? = null) {
    demo(FlavorDimension.contentType, applicationIdSuffix = ".demo"),
    prod(FlavorDimension.contentType)
}