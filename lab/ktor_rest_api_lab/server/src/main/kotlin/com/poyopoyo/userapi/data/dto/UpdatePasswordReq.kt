package com.poyopoyo.userapi.data.dto

import kotlinx.serialization.Serializable

@Serializable
data class UpdatePasswordReq(
    val oldPassword: String,
    val newPassword: String
)