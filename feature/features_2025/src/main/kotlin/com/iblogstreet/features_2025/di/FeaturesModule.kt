package com.iblogstreet.features_2025.di

import com.iblogstreet.features_2025.expose.FeaturesExpose
import com.iblogstreet.features_2025.exposeimpl.FeturesExposeImpl
import dagger.Binds
import dagger.Module
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

/**
 * @author junwang
 * @date 2025/05/28 0:46
 */
@Module
@InstallIn(SingletonComponent::class)
abstract class FeaturesModule {
    @Binds
    abstract fun bindFetauresExpose(featuresExposeImpl: FeturesExposeImpl): FeaturesExpose

}