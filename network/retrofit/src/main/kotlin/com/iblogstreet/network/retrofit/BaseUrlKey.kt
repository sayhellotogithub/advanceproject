package com.iblogstreet.network.retrofit

/**
 * @author junwang
 * @date 2025/07/30 18:49
 */
@JvmInline
value class BaseUrlKey(val value: String) {
    companion object {
        val Default = BaseUrlKey("default")
        val User = BaseUrlKey("user")
        val Auth = BaseUrlKey("auth")
    }
}
