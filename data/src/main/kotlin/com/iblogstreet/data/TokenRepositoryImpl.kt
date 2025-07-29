package com.iblogstreet.data

import com.iblogstreet.domain.repository.TokenRepository
import com.iblogstreet.infrastructurecore.EncryptedPrefsDataSource


class TokenRepositoryImpl(private val dataSource: EncryptedPrefsDataSource) : TokenRepository {

    override fun saveToken(token: String) {
        dataSource.saveToken(token)
    }

    override fun getToken(): String? {
        return dataSource.getToken()
    }

    override fun clearToken() {
        dataSource.clearToken()
    }
}