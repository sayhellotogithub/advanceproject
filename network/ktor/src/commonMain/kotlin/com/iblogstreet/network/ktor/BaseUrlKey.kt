package com.iblogstreet.network.ktor

@JvmInline
value class BaseUrlKey(val value: String) {
    companion object {
        val Default = BaseUrlKey("default")
        val User = BaseUrlKey("user")
        val Auth = BaseUrlKey("auth")
    }
}
