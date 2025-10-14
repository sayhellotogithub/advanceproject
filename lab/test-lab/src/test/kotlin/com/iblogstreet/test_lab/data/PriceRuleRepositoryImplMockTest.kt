package com.iblogstreet.test_lab.data

import com.google.common.truth.Truth.assertThat
import com.iblogstreet.test_lab.domain.models.PriceRule
import com.iblogstreet.test_lab.domain.models.Rank
import io.mockk.coVerify
import io.mockk.mockk
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.Test

/**
 * @author junwang
 * @date 2025/09/24 18:02
 */
class PriceRuleRepositoryImplMockTest {
    @Test
    fun `no coupon skips remote`() = runTest {
        val remote = mockk<RemoteDataSource>(relaxed = true)
        val local = DefaultLocal()
        val repo = PriceRuleRepositoryImpl(remote, local)

        val rule = repo.ruleFor(couponCode = null, rank = Rank.GOLD)
        assertThat(rule).isEqualTo(PriceRule(couponPercent = 0, rankPercent = 10))

        coVerify(exactly = 0) { remote.couponPercent(any()) }
    }
}