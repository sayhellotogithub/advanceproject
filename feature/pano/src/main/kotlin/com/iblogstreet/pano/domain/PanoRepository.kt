package com.iblogstreet.pano.domain

/**
 * @author junwang
 * @date 2025/09/19 14:31
 */
interface PanoRepository {
    suspend fun loadConfig(source: PanoSource): PanoConfig
    suspend fun getScene(config: PanoConfig, id: String): PanoConfig.Scene?
}

sealed interface PanoSource {
    data class Asset(val path: String) : PanoSource
    data class Remote(val url: String, val version: String? = null) : PanoSource
}

interface TelemetryRepository {
    suspend fun track(event: String, props: Map<String, Any?> = emptyMap())
}