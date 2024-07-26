package com.iblogstreet.photo.di

import com.iblogstreet.login.expose.LoginExpose
import com.iblogstreet.photo.expose.PhotoExpose
import com.iblogstreet.photo.exposeimpl.PhotoExposeImpl
import dagger.Binds
import dagger.Module
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

/**
 * @author junwang
 * @date 2024/07/16 0:00
 */
@Module
@InstallIn(SingletonComponent::class)
abstract class photoModule  {
    @Binds
    @Singleton
    abstract fun bindPhotoExpose(photoExposeImpl: PhotoExposeImpl):PhotoExpose
}