package com.iblogstreet.features_2025.exposeimpl

import android.content.Context
import com.iblogstreet.features_2025.FeaturesMainActivity
import com.iblogstreet.features_2025.expose.FeaturesExpose
import javax.inject.Inject
import javax.inject.Singleton

/**
 * @author junwang
 * @date 2025/05/28 0:51
 */
@Singleton
class FeturesExposeImpl @Inject constructor() : FeaturesExpose {
    override fun startFeaturesMainActivity(context: Context) {
        FeaturesMainActivity.start(context)
    }

}