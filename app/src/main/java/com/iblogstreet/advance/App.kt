package com.iblogstreet.advance

import android.app.Application
import dagger.hilt.android.HiltAndroidApp

/**
 * @author junwang
 * @date 2024/07/15 13:05
 */

@HiltAndroidApp
class App : Application() {
    override fun onCreate() {
        super.onCreate()
    }
}