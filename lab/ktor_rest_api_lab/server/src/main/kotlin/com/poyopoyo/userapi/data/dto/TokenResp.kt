package com.poyopoyo.userapi.data.dto

import kotlinx.serialization.Serializable

@Serializable
data class TokenResp(
    val accessToken: String
)