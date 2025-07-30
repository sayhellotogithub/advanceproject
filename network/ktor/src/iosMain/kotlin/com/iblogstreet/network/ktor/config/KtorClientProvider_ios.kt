package com.iblogstreet.network.ktor.config

import io.ktor.client.engine.*
import io.ktor.client.engine.darwin.*

actual fun defaultEngine(): HttpClientEngine {
    return Darwin.create()
}