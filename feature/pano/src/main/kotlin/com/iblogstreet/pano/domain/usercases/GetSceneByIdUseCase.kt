package com.iblogstreet.pano.domain.usercases

import com.iblogstreet.pano.domain.PanoConfig
import com.iblogstreet.pano.domain.PanoRepository

/**
 * @author junwang
 * @date 2025/09/19 14:38
 */
class GetSceneByIdUseCase(private val repo: PanoRepository) {
    suspend operator fun invoke(config: PanoConfig, id: String) = repo.getScene(config, id)
}