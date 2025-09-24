package com.iblogstreet.test_lab.domain.usecase

import com.iblogstreet.test_lab.domain.models.DiscountInput
import com.iblogstreet.test_lab.domain.repository.PriceRuleRepository
import kotlinx.coroutines.CoroutineDispatcher

/**
 * @author junwang
 * @date 2025/09/24 15:01
 */
class CalculateFinalPriceUseCase(
    private val repo: PriceRuleRepository,
    private val io: CoroutineDispatcher,
    private val capPercent: Int = 50
) {
    suspend operator fun invoke(input: DiscountInput): Int {
        require(input.basePrice >= 0) { "basePrice must be positive" }
        return with(io) {
            val rule = repo.ruleFor(input.couponCode, input.rank)
            val total = (rule.couponPercent + rule.rankPercent).coerceAtMost(capPercent)
            (input.basePrice * (100 - total) / 100).coerceAtLeast(1)
        }
    }
}