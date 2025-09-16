package com.iblogstreet.test_lab

import com.iblogstreet.test_lab.data.UserRepository
import com.iblogstreet.test_lab.presentation.viewmodel.UserVm
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test
import org.mockito.Mockito.mock
import org.mockito.kotlin.whenever

/**
 * @author junwang
 * @date 2025/09/16 15:36
 */
class UserRepositoryMockitoUnitTest {
    @Test
    fun `greet contains user name (Mockito)`() = runTest {
        val repo = mock<UserRepository>()
        whenever(repo.fetch()).thenReturn("Anna")

        val vm = UserVm(repo)
        assertEquals("Hello Anna", vm.greet())
    }
}
