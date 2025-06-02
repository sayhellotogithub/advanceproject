package com.iblogstreet.explore_ar.exposeimpl

import android.content.Context
import com.iblogstreet.explore_ar.ExploreARMainScreen
import com.iblogstreet.explore_ar.expose.ExploreArExpose
import javax.inject.Inject
import javax.inject.Singleton

/**
 * @author junwang
 * @date 2025/05/29 23:45
 */

@Singleton
class ExploreArExposeImpl @Inject constructor() : ExploreArExpose {

    override fun startExploreArMainScreen(context: Context) {
        ExploreARMainScreen.start(context)
    }
}