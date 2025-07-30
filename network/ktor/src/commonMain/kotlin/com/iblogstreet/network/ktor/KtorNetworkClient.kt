package com.iblogstreet.network.ktor

import com.iblogstreet.network.core.client.ApiBaseUrlProvider
import com.iblogstreet.network.core.client.INetworkClient
import com.iblogstreet.network.core.i18n.exception.EmptyResponseBodyException
import com.iblogstreet.network.core.model.ApiResult
import com.iblogstreet.network.core.util.safeApiCall
import io.ktor.client.*
import io.ktor.client.call.*
import io.ktor.client.plugins.*
import io.ktor.client.plugins.contentnegotiation.*
import io.ktor.client.request.*
import io.ktor.http.*
import io.ktor.serialization.kotlinx.json.json
import kotlinx.serialization.json.Json

class KtorNetworkClient(
    private val baseUrlProvider: ApiBaseUrlProvider,
    private val baseUrlKey: BaseUrlKey = BaseUrlKey.Default,
    private val httpClientFactory: () -> HttpClient = {
        HttpClient {
            install(ContentNegotiation) {
                json(Json { ignoreUnknownKeys = true })
            }
            install(HttpTimeout) {
                requestTimeoutMillis = 15_000
            }
        }
    }
) : INetworkClient {

    private val client: HttpClient by lazy { httpClientFactory() }

    override suspend inline fun <reified T : Any> get(path: String): ApiResult<T> = safeApiCall {
        val url = baseUrlProvider.getBaseUrl(baseUrlKey.value) + path
        client.get(url).body()
    }

    override suspend inline fun <reified T : Any, reified R : Any> post(path: String, body: T): ApiResult<R> = safeApiCall {
        val url = baseUrlProvider.getBaseUrl(baseUrlKey.value) + path
        client.post(url) {
            contentType(ContentType.Application.Json)
            setBody(body)
        }.body()
    }
}
