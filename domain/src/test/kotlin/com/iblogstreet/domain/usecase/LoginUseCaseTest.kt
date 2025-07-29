package com.iblogstreet.domain.usecase

import com.iblogstreet.data.LoginUseCaseImpl
import com.iblogstreet.domain.repository.TokenRepository
import io.mockk.mockk
import io.mockk.verify
import junit.framework.TestCase.assertTrue
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runTest
import org.junit.Test

/**
 * @author junwang
 * @date 2025/07/29 16:44
 */
@ExperimentalCoroutinesApi
class LoginUseCaseTest {
    private  val  mockTokenRepository = mockk<TokenRepository>(relaxed = true)
    private val loginUseCase = LoginUseCaseImpl(mockTokenRepository)

    @Test
    fun `test login with valid credentials return token`() = runTest {
        val result = loginUseCase.login("user", "pass")
        assertTrue(result.isSuccess)
        verify { mockTokenRepository.saveToken(any()) }
    }
}