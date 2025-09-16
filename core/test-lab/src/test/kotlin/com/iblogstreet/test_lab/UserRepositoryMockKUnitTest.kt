package com.iblogstreet.test_lab

import com.iblogstreet.test_lab.data.UserRepository
import com.iblogstreet.test_lab.presentation.viewmodel.UserVm
import io.mockk.coEvery
import io.mockk.coVerify
import io.mockk.mockk
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test

/**
 * @author junwang
 * @date 2025/09/16 15:45
 */
class UserRepositoryMockKUnitTest {
    @Test
    fun `greet contains user name (MockK)`() = runTest {
        val repo = mockk<UserRepository>()
        coEvery { repo.fetch() } returns "Anna"

        val vm = UserVm(repo)
        assertEquals("Hello Anna", vm.greet())
        coVerify(exactly = 1) { repo.fetch() }

    }
}