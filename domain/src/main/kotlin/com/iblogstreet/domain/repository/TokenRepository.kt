package com.iblogstreet.domain.repository

/**
 * @author junwang
 * @date 2025/07/28 23:25
 */
interface TokenRepository {
    fun saveToken(token:String)
    fun getToken(): String?
    fun clearToken()
}