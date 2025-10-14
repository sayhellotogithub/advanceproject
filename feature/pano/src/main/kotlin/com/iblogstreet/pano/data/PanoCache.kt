package com.iblogstreet.pano.data

import com.iblogstreet.pano.domain.PanoConfig

/**
 * @author junwang
 * @date 2025/09/19 14:49
 */
interface PanoCache {
    fun get(ver: String?): PanoConfig?
    fun put(ver: String?, conf: PanoConfig)
}