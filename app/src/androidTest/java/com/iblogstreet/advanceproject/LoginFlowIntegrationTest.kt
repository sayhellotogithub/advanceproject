package com.iblogstreet.advanceproject

import com.iblogstreet.domain.usecase.LoginUseCase
import dagger.hilt.android.testing.HiltAndroidRule
import dagger.hilt.android.testing.HiltAndroidTest
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertTrue
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import javax.inject.Inject

/**
 * @author junwang
 * @date 2025/07/29 18:35
 */
@HiltAndroidTest
class LoginFlowIntegrationTest {
    @get:Rule
    val hiltRule = HiltAndroidRule(this)

    @Inject
    lateinit var loginUseCase: LoginUseCase

    @Before
    fun init() {
        hiltRule.inject()
    }

    @Test
    fun testLoginFlow() = runTest {
        val result = loginUseCase.login("user", "pass")
        assertTrue(result.isSuccess)
    }

}