package com.iblogstreet.mvp

/**
 * @author junwang
 * @date 2024/07/31 23:53
 */
interface BaseView<T> {
    fun setPrsenter(presenter:T)
}