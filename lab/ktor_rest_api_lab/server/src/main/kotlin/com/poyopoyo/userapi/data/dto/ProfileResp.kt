package com.poyopoyo.userapi.data.dto

import kotlinx.serialization.Serializable

@Serializable
data class ProfileResp(
    val id: Long,
    val username: String,
    val email: String,
    val role: String,
    val status: String,
    val displayName: String? = null,
    val avatarUrl: String? = null
)
