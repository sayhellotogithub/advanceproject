package com.iblogstreet.network.core.client

/**
 * @author junwang
 * @date 2025/07/29 22:10
 */
interface ApiBaseUrlProvider {
    /**
     * @param key  "default", "auth", "user", "analytics" etc.
     */
    fun getBaseUrl(key: String): String
}