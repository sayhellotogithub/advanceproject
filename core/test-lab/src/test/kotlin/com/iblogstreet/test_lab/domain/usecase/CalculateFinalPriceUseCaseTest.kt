package com.iblogstreet.test_lab.domain.usecase

import com.iblogstreet.test_lab.domain.models.DiscountInput
import com.iblogstreet.test_lab.domain.models.PriceRule
import com.iblogstreet.test_lab.domain.models.Rank
import com.iblogstreet.test_lab.domain.repository.PriceRuleRepository
import io.mockk.coEvery
import io.mockk.mockk
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.test.runTest
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.assertThrows

/**
 * @author junwang
 * @date 2025/09/24 15:54
 */
class CalculateFinalPriceUseCaseTest {
    @Test
    fun `base only`() = runTest {
        val repo = mockk<PriceRuleRepository>()
        coEvery { repo.ruleFor(null, Rank.NONE) } returns PriceRule(couponPercent = 0, 0)
        val useCase = CalculateFinalPriceUseCase(repo, Dispatchers.IO)
        assertThat(useCase(DiscountInput(100))).isEqualTo(100)

    }

    @Test
    fun `cap at 50 percent`() = runTest() {
        val repo = mockk<PriceRuleRepository>()
        coEvery { repo.ruleFor("MEGA40", Rank.GOLD) } returns PriceRule(couponPercent = 40, 10)
        val useCase = CalculateFinalPriceUseCase(repo, Dispatchers.IO)
        assertThat(useCase(DiscountInput(1000, "MEGA40", rank = Rank.GOLD))).isEqualTo(500)
    }

    @Test
    fun `invalid base price`() = runTest {
        val useCase = CalculateFinalPriceUseCase(mockk(), Dispatchers.IO)
        assertThrows<IllegalArgumentException> {
            useCase(DiscountInput(-100))
        }

    }

}