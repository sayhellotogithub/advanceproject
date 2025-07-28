package com.iblogstreet.infrastructure.local

import android.content.Context
import androidx.core.content.edit
import androidx.security.crypto.EncryptedSharedPreferences
import androidx.security.crypto.MasterKey
import com.iblogstreet.infrastructurecore.EncryptedPrefsDataSource

/**
 * @author junwang
 * @date 2025/07/29 0:10
 */
class EncryptedPrefsDataSourceImpl(context: Context) : EncryptedPrefsDataSource {

    private val prefs = run {
        val masterKey = MasterKey.Builder(context)
            .setKeyScheme(MasterKey.KeyScheme.AES256_GCM)
            .build()

        EncryptedSharedPreferences.create(
            context,
            "secure_prefs",
            masterKey,
            EncryptedSharedPreferences.PrefKeyEncryptionScheme.AES256_SIV,
            EncryptedSharedPreferences.PrefValueEncryptionScheme.AES256_GCM
        )
    }

    override fun saveToken(token: String) {
        prefs.edit { putString("access_token", token) }
    }

    override fun getToken(): String? = prefs.getString("access_token", null)

    override fun clearToken() {
        prefs.edit { clear() }
    }


}
