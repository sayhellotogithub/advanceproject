package com.iblogstreet.pano.data

import android.content.Context
import com.iblogstreet.pano.domain.PanoConfig
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import kotlinx.serialization.json.Json

/**
 * @author junwang
 * @date 2025/09/19 14:42
 */
class AssetsDataSource(private val ctx: Context) {
    suspend fun loadJson(path: String): PanoConfig = withContext(Dispatchers.IO) {
        val json = ctx.assets.open(path).bufferedReader().use { it.readText() }
        Json { ignoreUnknownKeys = true }.decodeFromString(json)
    }
}
