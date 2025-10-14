package com.iblogstreet.pano.domain

/**
 * @author junwang
 * @date 2025/09/19 14:16
 */
@kotlinx.serialization.Serializable
data class PanoConfig(
    val scenes: List<Scene>,
    val entrySceneId: String
) {

    @kotlinx.serialization.Serializable
    data class Scene(
        val id: String,
        val name: String,
        val panorama: String,
        val defaultYaw: Double? = null,
        val hotspots: List<Hotspot> = emptyList()
    )

    @kotlinx.serialization.Serializable
    data class Hotspot(
        val id: String,
        val type: String, // nav/info/action
        val tooltip: String? = null,
        val longitude: Double,
        val latitude: Double,
        val targetSceneId: String? = null,
        val payload: Map<String, String>? = null
    )

}