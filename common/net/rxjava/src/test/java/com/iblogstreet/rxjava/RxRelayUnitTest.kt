package com.iblogstreet.rxjava

import com.jakewharton.rxrelay3.PublishRelay
import io.reactivex.rxjava3.disposables.CompositeDisposable
import io.reactivex.rxjava3.kotlin.subscribeBy
import org.junit.Test

/**
 * @author junwang
 * @date 2024/07/05 0:36
 */
class RxRelayUnitTest {
    @Test
    fun rxRelayTest() {
        //RxRelay mimics all of the subjects you’ve come to know and love, but without the option of calling onComplete or onError
        val subscription = CompositeDisposable()
        val publishRelay = PublishRelay.create<Int>()
        subscription.add(publishRelay.subscribeBy(onNext = { println("@$it") }))
        publishRelay.accept(1)
        publishRelay.accept(2)
        publishRelay.accept(3)
    }
}