package com.iblogstreet.test_lab.data

import com.iblogstreet.test_lab.domain.models.Rank

/**
 * @author junwang
 * @date 2025/09/24 15:13
 */
interface LocalDataSource {
    fun rankPercent(rank: Rank): Int
}