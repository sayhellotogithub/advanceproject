package com.iblogstreet.login

import com.iblogstreet.domain.usecase.LoginUseCase
import com.iblogstreet.login.viewmodel.LoginViewModel
import io.mockk.coEvery
import io.mockk.mockk
import junit.framework.TestCase.assertEquals
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.advanceUntilIdle
import kotlinx.coroutines.test.runTest
import org.junit.Before
import org.junit.Test

/**
 * @author junwang
 * @date 2025/07/29 18:04
 */
@ExperimentalCoroutinesApi
class LoginViewModelTest {

    private val useCase = mockk<LoginUseCase>()

    private lateinit var viewModel: LoginViewModel

    @Before
    fun setUp() {
        viewModel = LoginViewModel(useCase)
    }

    @Test
    fun `login updates tokenResult on success`() = runTest {
        coEvery { useCase.login(any(), any()) } returns Result.success("token123")

        viewModel.login("user", "pass")
        advanceUntilIdle()

        val result = viewModel.tokenResult.value
        println(result?.getOrNull())
        assertEquals(true, result?.isSuccess)

        assertEquals("token123", result?.getOrNull())
    }

    @Test
    fun `login updates tokenResult on failure`() = runTest {
        coEvery { useCase.login(any(), any()) } returns Result.failure(Exception("Login failed"))

        viewModel.login("user", "wrongPass")

        val result = viewModel.tokenResult.value
        assertEquals("Login failed", result?.exceptionOrNull()?.message)
    }

}