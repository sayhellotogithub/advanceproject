

package com.iblogstreet.rxjavatest.ui.time.utils

import android.os.Handler
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.disposables.Disposable
import java.util.concurrent.TimeUnit

fun dispatchAfter(delayInMs: Long, runnable: () -> Unit) {
  Handler().postDelayed(runnable, delayInMs)
}

fun <T : Any> timer(elementsPerSecond: Int, action: () -> T): Disposable {
  val millis = (1f / elementsPerSecond) * 1000
  return Observable.interval(millis.toLong(), TimeUnit.MILLISECONDS, AndroidSchedulers.mainThread())
      .map { action() }
      .subscribe()
}
