package com.iblogstreet.explore_ar.di

import com.iblogstreet.explore_ar.expose.ExploreArExpose
import com.iblogstreet.explore_ar.exposeimpl.ExploreArExposeImpl
import dagger.Binds
import dagger.Module
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent

/**
 * @author junwang
 * @date 2025/05/29 23:55
 */
@Module
@InstallIn(SingletonComponent::class)
abstract class ExploreArModule {
    @Binds
    abstract fun bindExploreArRepository(exploreArRepositoryImpl: ExploreArExposeImpl): ExploreArExpose
}