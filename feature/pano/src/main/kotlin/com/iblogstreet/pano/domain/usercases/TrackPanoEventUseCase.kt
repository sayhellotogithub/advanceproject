package com.iblogstreet.pano.domain.usercases

import com.iblogstreet.pano.domain.TelemetryRepository

/**
 * @author junwang
 * @date 2025/09/19 14:39
 */
class TrackPanoEventUseCase(private val repo: TelemetryRepository) {
    suspend operator fun invoke(name: String, props: Map<String, Any?> = emptyMap()) =
        repo.track(name, props)
}