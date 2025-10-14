package com.iblogstreet.mvptest

import com.iblogstreet.mvp.IPresenter
import com.iblogstreet.mvp.IView
import com.iblogstreet.mvptest.bean.NewsBean

/**
 * @author junwang
 * @date 2025/02/14 17:35
 */
interface MvpMainContract {
    interface Presenter : IPresenter<View> {
        fun loadNews(onSuccess: (NewsBean) -> Unit)
    }

    interface View : IView {
    }
}