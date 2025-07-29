package com.iblogstreet.infrastructurecore

interface EncryptedPrefsDataSource {
    fun saveToken(token: String)
    fun getToken(): String?
    fun clearToken()
}