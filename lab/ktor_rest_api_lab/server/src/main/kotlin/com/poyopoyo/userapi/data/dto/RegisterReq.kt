package com.poyopoyo.userapi.data.dto

import kotlinx.serialization.Serializable

@Serializable
data class RegisterReq(
    val username: String,
    val email: String,
    val password: String
)