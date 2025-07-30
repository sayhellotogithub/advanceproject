package com.iblogstreet.network.retrofit

import com.google.gson.reflect.TypeToken
import com.iblogstreet.network.core.client.ApiBaseUrlProvider
import com.iblogstreet.network.core.client.INetworkClient
import com.iblogstreet.network.core.i18n.exception.EmptyResponseBodyException
import com.iblogstreet.network.core.model.ApiResult
import com.iblogstreet.network.core.util.safeApiCall
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.ResponseBody
import okhttp3.ResponseBody.Companion.toResponseBody
import retrofit2.Converter
import retrofit2.Retrofit

class RetrofitNetworkClient(
    private val baseUrlProvider: ApiBaseUrlProvider,
    private val baseUrlKey: BaseUrlKey = BaseUrlKey.Auth,
    private val retrofitFactory: (String) -> Retrofit = { RetrofitProvider.create(it) }
) : INetworkClient {

    private val retrofitCache = mutableMapOf<String, Retrofit>()
    private val okHttpClient = OkHttpClient.Builder()
        .addInterceptor(LoggingInterceptorProvider.get())
        .build()
    private val contentType = "application/json".toMediaType()

    private fun retrofit(serviceKey: String): Retrofit {
        return retrofitCache.getOrPut(serviceKey) {
            retrofitFactory(baseUrlProvider.getBaseUrl(serviceKey))
        }
    }

    override suspend fun <T : Any> get(path: String): ApiResult<T> = safeApiCall {
        val url = baseUrlProvider.getBaseUrl(baseUrlKey.value) + path
        val request = Request.Builder().url(url).get().build()
        val response = okHttpClient.newCall(request).execute()

        val body = response.body?.string() ?: throw EmptyResponseBodyException()
        val type = object : TypeToken<T>() {}.type
        val converter: Converter<ResponseBody, T> =
            retrofit(baseUrlKey.value).responseBodyConverter(type, arrayOf())
        converter.convert(body.toResponseBody(contentType))!!
    }

    override suspend fun <T : Any, R : Any> post(path: String, body: T): ApiResult<R> =
        safeApiCall {
            val key = baseUrlKey.value
            val url = baseUrlProvider.getBaseUrl(key) + path

            val requestType = object : TypeToken<T>() {}.type
            val requestConverter = retrofit(key).requestBodyConverter<T>(
                requestType, arrayOf(), emptyArray()
            )
            val requestBody = requestConverter.convert(body)!!

            val request = Request.Builder()
                .url(url)
                .post(requestBody)
                .build()

            val response = okHttpClient.newCall(request).execute()
            val responseBody = response.body?.string() ?: throw EmptyResponseBodyException()

            val type = object : TypeToken<R>() {}.type
            val responseConverter: Converter<ResponseBody, R> =
                retrofit(key).responseBodyConverter(type, arrayOf())
            responseConverter.convert(responseBody.toResponseBody(contentType))!!
        }
}