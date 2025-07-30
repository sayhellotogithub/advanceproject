package com.iblogstreet.network.ktor.config

/**
 * @author junwang
 * @date 2025/07/30 21:45
 */

import io.ktor.client.HttpClient
import io.ktor.client.engine.HttpClientEngine
import io.ktor.client.plugins.HttpTimeout
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.client.plugins.logging.DEFAULT
import io.ktor.serialization.kotlinx.json.json
import kotlinx.serialization.json.Json

object KtorClientProvider {
    fun create(
        engine: HttpClientEngine? = null,
        enableLogging: Boolean = false,
        requestTimeoutMillis: Long = 15_000L
    ): HttpClient {
        return HttpClient(engine ?: defaultEngine()) {
            install(ContentNegotiation) {
                json(Json {
                    ignoreUnknownKeys = true
                    isLenient = true
                    encodeDefaults = true
                })
            }
            install(HttpTimeout) {
                this.requestTimeoutMillis = requestTimeoutMillis
            }

            if (enableLogging) {
                install(io.ktor.client.plugins.logging.Logging) {
                    level = io.ktor.client.plugins.logging.LogLevel.ALL
                    logger = io.ktor.client.plugins.logging.Logger.DEFAULT
                }
            }
        }
    }
}

/**
 * Provides a default HttpClientEngine, suitable for multi-platform common logic
 */
expect fun defaultEngine(): HttpClientEngine
