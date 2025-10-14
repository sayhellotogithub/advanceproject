package com.iblogstreet.mvptest

import com.iblogstreet.mvptest.bean.NewsBean
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

/**
 * @author junwang
 * @date 2025/02/14 17:41
 */
class MvpMainPresenter(view: MvpMainContract.View) : MvpMainContract.Presenter {
    private var view: MvpMainContract.View? = view
    private val presenterScope = CoroutineScope(Dispatchers.Main + SupervisorJob())

    override fun loadNews(onSuccess: (NewsBean) -> Unit) {
        presenterScope.launch {
            withContext(Dispatchers.Main) {
                onSuccess(
                    NewsBean(
                        newId = "001",
                        "Brown",
                        "2025-02-02"
                    )
                )
            }

        }

    }


    override fun detachView() {
        this.view = null
        presenterScope.cancel()
    }
}