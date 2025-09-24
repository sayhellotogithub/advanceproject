package com.iblogstreet.test_lab.data

import com.iblogstreet.test_lab.domain.models.PriceRule
import com.iblogstreet.test_lab.domain.models.Rank
import com.iblogstreet.test_lab.domain.repository.PriceRuleRepository

/**
 * @author junwang
 * @date 2025/09/24 15:08
 */
class PriceRuleRepositoryImpl(
    private val remote: RemoteDataSource, private val local: LocalDataSource
) : PriceRuleRepository {
    override suspend fun ruleFor(couponCode: String?, rank: Rank): PriceRule {
        val couponPercent = if (couponCode.isNullOrBlank()) 0 else remote.couponPercent(couponCode)
        val rankPercent = local.rankPercent(rank)
        return PriceRule(couponPercent, rankPercent)
    }

}