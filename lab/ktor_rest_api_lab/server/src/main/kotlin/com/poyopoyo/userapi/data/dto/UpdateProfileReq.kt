package com.poyopoyo.userapi.data.dto

import kotlinx.serialization.Serializable

@Serializable
data class UpdateProfileReq(
    val displayName: String? = null,
    val avatarUrl: String? = null
)