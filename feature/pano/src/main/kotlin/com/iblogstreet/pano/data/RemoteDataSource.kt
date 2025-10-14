package com.iblogstreet.pano.data

import com.iblogstreet.pano.domain.PanoConfig
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import okhttp3.OkHttpClient
import okhttp3.Request

/**
 * @author junwang
 * @date 2025/09/19 14:45
 */
class RemoteDataSource(private val http: OkHttpClient, private val cache: PanoCache) {
    suspend fun fetchJson(url: String, version: String?): PanoConfig =
        withContext(Dispatchers.IO) {
            cache.get(version)?.let { return@withContext it }
            val resp = http.newCall(Request.Builder().url(url).build()).execute()
            val body = requireNotNull(resp.body).string()
            val conf = kotlinx.serialization.json.Json { ignoreUnknownKeys = true }
                .decodeFromString<PanoConfig>(body)
            cache.put(version, conf)
            conf
        }
}