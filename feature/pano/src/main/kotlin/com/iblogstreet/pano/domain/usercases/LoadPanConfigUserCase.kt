package com.iblogstreet.pano.domain.usercases

import com.iblogstreet.pano.domain.PanoRepository
import com.iblogstreet.pano.domain.PanoSource

/**
 * @author junwang
 * @date 2025/09/19 14:36
 */
class LoadPanConfigUserCase(private val repo: PanoRepository) {
    suspend operator fun invoke(source: PanoSource) = repo.loadConfig(source)
}