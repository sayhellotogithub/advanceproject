package com.iblogstreet.features_2025

import android.content.Context
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import dagger.hilt.android.AndroidEntryPoint

/**
 * @author junwang
 * @date 2025/05/28 0:42
 */
@AndroidEntryPoint
class FeaturesMainActivity:AppCompatActivity() {

    companion object {
        @JvmStatic
        internal fun start(context: Context) {
            val intent = Intent(context, FeaturesMainActivity::class.java)
            context.startActivity(intent)
        }
    }

}