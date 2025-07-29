package com.iblogstreet.infrastructure.local

import android.content.Context
import androidx.core.content.edit
import androidx.security.crypto.EncryptedSharedPreferences
import androidx.security.crypto.MasterKey
import com.iblogstreet.infrastructurecore.EncryptedPrefsDataSource
import javax.inject.Inject

/**
 * @author junwang
 * @date 2025/07/29 0:10
 */
class EncryptedPrefsDataSourceImpl @Inject constructor(context: Context) :
    EncryptedPrefsDataSource {
    companion object {
        private const val FILE_NAME = "secure_prefs"
        private const val KEY_ACCESS_TOKEN = "access_token"
    }

    private val prefs by lazy {
        val masterKey = MasterKey.Builder(context)
            .setKeyScheme(MasterKey.KeyScheme.AES256_GCM)
            .build()

        EncryptedSharedPreferences.create(
            context,
            FILE_NAME,
            masterKey,
            EncryptedSharedPreferences.PrefKeyEncryptionScheme.AES256_SIV,
            EncryptedSharedPreferences.PrefValueEncryptionScheme.AES256_GCM
        )
    }

    override fun saveToken(token: String) {
        prefs.edit { putString(KEY_ACCESS_TOKEN, token) }
    }

    override fun getToken(): String? = prefs.getString(KEY_ACCESS_TOKEN, null)

    override fun clearToken() {
        prefs.edit { clear() }
    }


}
