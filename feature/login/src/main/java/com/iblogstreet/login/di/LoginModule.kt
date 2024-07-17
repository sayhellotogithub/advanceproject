package com.iblogstreet.login.di

import com.iblogstreet.login.expose.LoginExpose
import com.iblogstreet.login.exposeimpl.LoginExposeImpi
import dagger.Binds
import dagger.Module
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

/**
 * @author junwang
 * @date 2024/07/15 23:38
 */
@Module
@InstallIn(SingletonComponent::class)
abstract class LoginModule {
    @Binds
    @Singleton
    abstract fun bindLoginExpose(loginExposeImpl:LoginExposeImpi):LoginExpose
}