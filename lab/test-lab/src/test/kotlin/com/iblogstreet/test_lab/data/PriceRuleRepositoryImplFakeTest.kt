package com.iblogstreet.test_lab.data

import com.google.common.truth.Truth.assertThat
import com.iblogstreet.test_lab.domain.models.PriceRule
import com.iblogstreet.test_lab.domain.models.Rank
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.Test

/**
 * @author junwang
 * @date 2025/09/24 17:56
 */
class PriceRuleRepositoryImplFakeTest {
    @Test
    fun `compose remote+local`() = runTest {
        val repo = PriceRuleRepositoryImpl(remote = FakeRemote(), local = DefaultLocal())
        val rule = repo.ruleFor(couponCode = "SUMMER10", rank = Rank.SILVER)
        assertThat(rule).isEqualTo(PriceRule(couponPercent = 10, rankPercent = 5))
    }
}