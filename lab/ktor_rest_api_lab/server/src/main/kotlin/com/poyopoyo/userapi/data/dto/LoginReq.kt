package com.poyopoyo.userapi.data.dto

import kotlinx.serialization.Serializable

@Serializable
data class LoginReq(
    val usernameOrEmail: String,
    val password: String
)
