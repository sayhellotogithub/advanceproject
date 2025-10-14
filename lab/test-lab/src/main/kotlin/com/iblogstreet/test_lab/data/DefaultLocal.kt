package com.iblogstreet.test_lab.data

import com.iblogstreet.test_lab.domain.models.Rank

/**
 * @author junwang
 * @date 2025/09/24 15:23
 */
class DefaultLocal : LocalDataSource {
    override fun rankPercent(rank: Rank): Int {
        return when (rank) {
            Rank.NONE -> 0
            Rank.SILVER -> 5
            Rank.GOLD -> 10
        }
    }
}