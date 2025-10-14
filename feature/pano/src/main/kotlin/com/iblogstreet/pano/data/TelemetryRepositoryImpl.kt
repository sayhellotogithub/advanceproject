package com.iblogstreet.pano.data

import com.iblogstreet.pano.domain.TelemetryRepository

/**
 * @author junwang
 * @date 2025/09/19 14:51
 */
class TelemetryRepositoryImpl : TelemetryRepository {
    override suspend fun track(event: String, props: Map<String, Any?>) {
        KotlinLogging().d("PanoTrack", "$event $props")
    }
}