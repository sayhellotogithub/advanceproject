package com.iblogstreet.login.exposeimpl

import android.content.Context
import com.iblogstreet.login.LoginActivity
import com.iblogstreet.login.expose.LoginExpose
import javax.inject.Inject
import javax.inject.Singleton

/**
 * @author junwang
 * @date 2024/07/15 23:34
 */
@Singleton
class LoginExposeImpl @Inject constructor() : LoginExpose {
    override fun startLoginActivity(context: Context) {
        LoginActivity.start(context)
    }
}
