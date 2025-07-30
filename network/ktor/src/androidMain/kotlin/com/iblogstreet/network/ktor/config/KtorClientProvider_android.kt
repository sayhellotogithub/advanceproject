package com.iblogstreet.network.ktor.config

import io.ktor.client.engine.*
import io.ktor.client.engine.okhttp.*

actual fun defaultEngine(): HttpClientEngine {
    return OkHttp.create()
}