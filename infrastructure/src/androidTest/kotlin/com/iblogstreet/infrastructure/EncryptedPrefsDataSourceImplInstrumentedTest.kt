package com.iblogstreet.infrastructure


import android.content.Context
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.iblogstreet.infrastructure.local.EncryptedPrefsDataSourceImpl
import com.iblogstreet.infrastructurecore.EncryptedPrefsDataSource
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import kotlin.test.assertEquals

/**
 * @author junwang
 * @date 2025/07/29 17:14
 */
@RunWith(AndroidJUnit4::class)
class EncryptedPrefsDataSourceImplInstrumentedTest {
    private lateinit var dataSource: EncryptedPrefsDataSource

    @Before
    fun setUp() {
        val context = ApplicationProvider.getApplicationContext<Context>()
        dataSource = EncryptedPrefsDataSourceImpl(context)
    }

    @Test
    fun testEncryptedPrefsDataSource() {
        dataSource.saveToken("secure_token")
        assertEquals("secure_token", dataSource.getToken())
    }

}