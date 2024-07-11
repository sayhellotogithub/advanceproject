package config

internal object Versioning {
    private const val LOCAL_VERSION_CODE = 1
    private const val LOCAL_VERSION_NAME = "1.0.0"
    private const val MAJOR_VERSION = "1.0.0"

    internal fun versionCode(): Int {
        val versionCode =
            try {
                System.getenv(EnvKeys.IBLOG_BUILD_NUMBER).toIntOrNull()
            } catch (nullPointerException: NullPointerException) {
                null
            }
        return versionCode ?: LOCAL_VERSION_CODE
    }

    internal fun versionName(): String {
        val versionName = try {
            "$MAJOR_VERSION.${System.getenv(EnvKeys.IBLOG_BUILD_NUMBER)}"
        } catch (nullPointerException: NullPointerException) {
            null
        }

        return versionName?.ifEmpty { LOCAL_VERSION_NAME } ?: LOCAL_VERSION_NAME
    }
}