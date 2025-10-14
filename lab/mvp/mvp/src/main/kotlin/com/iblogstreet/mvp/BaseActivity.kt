package com.iblogstreet.mvp

import androidx.activity.ComponentActivity


/**
 * @author junwang
 * @date 2025/02/14 17:54
 */
abstract class BaseActivity<T> : ComponentActivity(), IView {
    abstract val presenter: T
    override fun hideProgress() {
    }

    override fun showProgress() {
    }

    override fun showNNotice(type: Int, notice: String) {
    }
}