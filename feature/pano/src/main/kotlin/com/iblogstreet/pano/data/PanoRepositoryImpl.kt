package com.iblogstreet.pano.data

import com.iblogstreet.pano.domain.PanoRepository

/**
 * @author junwang
 * @date 2025/09/19 14:41
 */
class PanoRepositoryImpl(private val assets:AssetsDataSource, private val remote:RemoteDataSource):PanoRepository {
}
