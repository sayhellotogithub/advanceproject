package com.iblogstreet.rxjava

import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.disposables.CompositeDisposable
import io.reactivex.rxjava3.disposables.Disposable
import io.reactivex.rxjava3.kotlin.Observables
import io.reactivex.rxjava3.kotlin.subscribeBy
import io.reactivex.rxjava3.subjects.PublishSubject
import org.junit.Test

/**
 * @author junwang
 * @date 2024/07/25 22:57
 */
class RxjavaFilteringOperatorsUnitTest {

    @Test
    fun ignoringOperatorsTest() {
        //ignoreElements is useful when you only want to be notified when an observable has terminated, via a complete or error event.
        val disposable = CompositeDisposable()
        val subscription = PublishSubject.create<String>()
        disposable.add(subscription.ignoreElements().subscribeBy(onComplete = {
            println("first subscription complete")
        }, onError = {
            println("first subscription ${it.message}")
        }))
        subscription.onNext("1")
        subscription.onNext("2")
        disposable.add(subscription.subscribeBy(onNext = { println("$it") }))
        subscription.onNext("3")
        subscription.onComplete()

    }

    @Test
    fun elementAtTest() {
        //you can use elementAt, which takes the index of the element you want to receive, and it ignores everything else.
        val disposable = CompositeDisposable()
        val subscription = PublishSubject.create<String>()
        disposable.add(subscription.elementAt(1).subscribeBy(onSuccess = {
            println("first subscription onSuccess $it")
        }, onComplete = {
            println("first subscription complete")
        }, onError = {
            println("first subscription ${it.message}")
        }))

        subscription.onNext("1")
        subscription.onNext("2")
        disposable.add(subscription.subscribeBy(onNext = { println("$it") }))
        subscription.onNext("3")
        subscription.onComplete()

    }

    @Test
    fun filterTest() {
        val disposable = CompositeDisposable()
        val subscription = PublishSubject.create<Int>()
        disposable.add(subscription.filter { it ->
            it > 4
        }.subscribeBy(
            onNext = {
                println("first subscription  $it")
            }
        ))


        subscription.onNext(2)
        subscription.onNext(5)
        subscription.onNext(10)
        disposable.add(subscription.subscribeBy(
            onNext = {
                println("second subscription  $it")
            }
        ))

//        disposable.add(Observable.fromIterable(listOf(2, 3, 4, 9, 10, 11)).filter { it -> it > 5 }
//            .subscribeBy(onNext = {
//                println("second subscription  $it")
//            }))

    }

    @Test
    fun skipTest() {
        val disposable = CompositeDisposable()

        disposable.add(
            Observable.just("A", "B", "C", "D", "E", "F")
                .skip(3)
                .subscribe {
                    println(it)
                })
    }

    @Test
    fun skipWhileTest() {
        //Like filter, skipWhile lets you include a predicate to determine what should be skipped.
        // However, unlike filter, which will filter elements for the life of the subscription,
        // skipWhile will only skip up until something is not skipped, and then it will let everything else through from that point on.
        val subscriptions = CompositeDisposable()

        subscriptions.add(
            Observable.just(0, 6, 4, 1, 2, 3, 45, 6)
                .skipWhile { it % 2 == 0 }
                .subscribe {
                    println(it)
                })
    }

    @Test
    fun skipUntilTest() {
        //The first is skipUntil, which will keep skipping elements from the source observable (the one you’re subscribing to) until some other trigger observable emits.
        val disposable = CompositeDisposable()
        val subscriptionA = PublishSubject.create<String>()
        val subscriptionB = PublishSubject.create<String>()
        disposable.add(subscriptionA.skipUntil(subscriptionB).subscribeBy {
            println(it)
        })
        subscriptionA.onNext("1")
        subscriptionA.onNext("2")
        subscriptionB.onNext("A")

        subscriptionA.onNext("3")

    }

    @Test
    fun takeTest() {
        val disposable = CompositeDisposable()
        disposable.add(Observable.just(1, 2, 3, 4).take(3).subscribeBy {
            println(it)
        })

    }

    @Test
    fun takeWhile() {
        val disposable = CompositeDisposable()
        disposable.add(
            Observable.fromIterable(listOf(1, 5, 6, 9, 0, 12, 8)).takeWhile { it -> it < 5 }
                .subscribeBy {
                    println(it)
                })
    }

    @Test
    fun takeUntilTest() {
        val disposable = CompositeDisposable()
        val subscriptionA = PublishSubject.create<String>()
        val subscriptionB = PublishSubject.create<String>()
        disposable.add(subscriptionA.takeUntil(subscriptionB).subscribeBy {
            println(it)
        })
        subscriptionA.onNext("1")
        subscriptionA.onNext("2")
        subscriptionB.onNext("A")

        subscriptionA.onNext("3")

    }

    @Test
    fun distinctUntilChangedTest() {
        val disposable = CompositeDisposable()
        disposable.add(Observable.just("A", "B", "B", "C", "A").distinctUntilChanged().subscribeBy {
            println(it)
        })

        disposable.add(
            (Observable.just(
                "ABC",
                "BCD",
                "CDE",
                "FGH",
                "IJK",
                "JKL",
                "LMN"
            )).distinctUntilChanged { first, second ->
                second.any { it in first }

            }.toList().subscribeBy {
                println(it)
            })
    }

    @Test
    fun phoneNumberTest() {
        val disposable = CompositeDisposable()
        val subscription = PublishSubject.create<Int>()
        disposable.add(subscription.skipWhile { it ->
            it != 0

        }.filter {
            it < 10
        }.take(10).toList().subscribeBy {
            println(it)
        })
        subscription.onNext(0)
        subscription.onNext(4)
        subscription.onNext(6)
        subscription.onNext(7)
        subscription.onNext(7)
        subscription.onNext(6)
        subscription.onNext(7)
        subscription.onNext(6)
        subscription.onNext(7)
        subscription.onNext(6)
        subscription.onNext(7)
        subscription.onNext(11)
        subscription.onNext(7)

    }
}