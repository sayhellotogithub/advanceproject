package com.iblogstreet.test_lab.domain.models

/**
 * @author junwang
 * @date 2025/09/24 14:57
 */
data class DiscountInput(
    val basePrice: Int,
    val couponCode: String? = null,
    val rank: Rank = Rank.NONE
)