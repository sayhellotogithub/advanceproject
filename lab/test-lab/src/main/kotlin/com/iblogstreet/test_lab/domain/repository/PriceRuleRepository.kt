package com.iblogstreet.test_lab.domain.repository

import com.iblogstreet.test_lab.domain.models.PriceRule
import com.iblogstreet.test_lab.domain.models.Rank

/**
 * @author junwang
 * @date 2025/09/24 15:00
 */
interface PriceRuleRepository {
    suspend fun ruleFor(couponCode: String?, rank: Rank): PriceRule
}