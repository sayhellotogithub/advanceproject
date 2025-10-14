package com.iblogstreet.pano.data

import com.iblogstreet.pano.domain.PanoConfig

/**
 * @author junwang
 * @date 2025/09/19 14:50
 */
class MemPanoCache: PanoCache {
    private val map = mutableMapOf<String?, PanoConfig>()
    override fun get(ver: String?) = map[ver]
    override fun put(ver: String?, conf: PanoConfig) { map[ver] = conf }
}
