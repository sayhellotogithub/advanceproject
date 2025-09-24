package com.iblogstreet.test_lab.presentation.viewmodel

import app.cash.turbine.test
import com.google.common.truth.Truth.assertThat
import com.iblogstreet.test_lab.domain.models.DiscountInput
import com.iblogstreet.test_lab.domain.models.PriceRule
import com.iblogstreet.test_lab.domain.models.Rank
import com.iblogstreet.test_lab.domain.repository.PriceRuleRepository
import com.iblogstreet.test_lab.domain.usecase.CalculateFinalPriceUseCase
import io.mockk.coEvery
import io.mockk.mockk
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.UnconfinedTestDispatcher
import kotlinx.coroutines.test.advanceUntilIdle
import kotlinx.coroutines.test.resetMain
import kotlinx.coroutines.test.runCurrent
import kotlinx.coroutines.test.runTest
import kotlinx.coroutines.test.setMain
import kotlinx.coroutines.yield
import org.junit.jupiter.api.Test
import kotlin.test.AfterTest
import kotlin.test.BeforeTest

/**
 * @author junwang
 * @date 2025/09/24 18:15
 */
@OptIn(ExperimentalCoroutinesApi::class)
class PriceViewModelTest {
    private val testDispatcher = UnconfinedTestDispatcher()

    @BeforeTest
    fun setup() {
        Dispatchers.setMain(testDispatcher)
    }

    @AfterTest
    fun tearDown() {
        Dispatchers.resetMain()
    }

    @Test
    fun `emit loading then result`() = runTest {
        val repo = mockk<PriceRuleRepository>()
        coEvery { repo.ruleFor("SUMMER10", Rank.NONE) }.coAnswers {
            yield()
            PriceRule(10, 0)
        }

        val useCase = CalculateFinalPriceUseCase(repo, io = UnconfinedTestDispatcher(testScheduler))

        val vm = PriceViewModel(useCase)
        vm.uiState.test {
            // 初期値
            assertThat(awaitItem()).isEqualTo(UiState())

            vm.calc(DiscountInput(1000, "SUMMER10"))
            // Step 1: loading を観測
            runCurrent()
            val loading = awaitItem()
            assertThat(loading.loading).isTrue()

            // Step 2: 結果を観測
            advanceUntilIdle()
            val done = awaitItem()
            assertThat(done.loading).isFalse()
            assertThat(done.finalPrice).isEqualTo(900)

            cancelAndConsumeRemainingEvents()

        }
    }
}