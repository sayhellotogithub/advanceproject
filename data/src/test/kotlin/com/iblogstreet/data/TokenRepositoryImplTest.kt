package com.iblogstreet.data

import com.iblogstreet.infrastructurecore.EncryptedPrefsDataSource
import io.mockk.mockk
import io.mockk.verify
import org.junit.Test

/**
 * @author junwang
 * @date 2025/07/29 17:10
 */
class TokenRepositoryImplTest {
    private  val mockDataSource = mockk<EncryptedPrefsDataSource>(relaxed = true)
    private val repository = TokenRepositoryImpl(mockDataSource)

    @Test
    fun `test saveToken should delegate to dataSource`() {
        repository.saveToken("abc123")
        verify { mockDataSource.saveToken("abc123") }
    }
}