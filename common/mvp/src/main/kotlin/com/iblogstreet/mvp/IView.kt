package com.iblogstreet.mvp

import android.content.Context

/**
 * @author junwang
 * @date 2024/07/31 23:53
 */
interface IView {
    /**
     * Show progress bar
     */
    fun showProgress()

    /**
     * Hide progress bar
     */
    fun hideProgress()
    fun showNNotice(type: Int,notice:String)
    fun getContext(): Context

}