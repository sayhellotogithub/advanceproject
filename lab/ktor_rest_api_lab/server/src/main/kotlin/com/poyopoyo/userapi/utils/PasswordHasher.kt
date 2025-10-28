package com.poyopoyo.userapi.utils


import at.favre.lib.crypto.bcrypt.BCrypt

object PasswordHasher {
    fun hash(raw: String): String =
        BCrypt.withDefaults().hashToString(12, raw.toCharArray())

    fun verify(raw: String, hashed: String): Boolean =
        BCrypt.verifyer().verify(raw.toCharArray(), hashed).verified
}
