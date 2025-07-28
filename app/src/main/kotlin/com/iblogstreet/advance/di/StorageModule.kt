package com.iblogstreet.advance.di

import android.content.Context
import com.iblogstreet.data.LoginUseCaseImpl
import com.iblogstreet.data.TokenRepositoryImpl
import com.iblogstreet.domain.repository.TokenRepository
import com.iblogstreet.domain.usecase.LoginUseCase
import com.iblogstreet.infrastructure.local.EncryptedPrefsDataSourceImpl
import com.iblogstreet.infrastructurecore.EncryptedPrefsDataSource
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

/**
 * @author junwang
 * @date 2025/07/29 0:38
 */
@Module
@InstallIn(SingletonComponent::class)
object StorageModule {
    @Provides
    @Singleton
    fun provideEncryptedPrefsDataSource(
        @ApplicationContext context: Context
    ): EncryptedPrefsDataSource = EncryptedPrefsDataSourceImpl(context)

    @Provides
    @Singleton
    fun provideTokenRepository(
        dataSource: EncryptedPrefsDataSource
    ): TokenRepository = TokenRepositoryImpl(dataSource)

    @Provides
    @Singleton
    fun provideLoginUseCase(
        tokenRepository: TokenRepository
    ): LoginUseCase = LoginUseCaseImpl(tokenRepository)
}