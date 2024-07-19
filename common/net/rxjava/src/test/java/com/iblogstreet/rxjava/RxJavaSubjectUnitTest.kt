package com.iblogstreet.rxjava

import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.disposables.CompositeDisposable
import io.reactivex.rxjava3.kotlin.Observables
import io.reactivex.rxjava3.kotlin.subscribeBy
import io.reactivex.rxjava3.subjects.AsyncSubject
import io.reactivex.rxjava3.subjects.BehaviorSubject
import io.reactivex.rxjava3.subjects.PublishSubject
import io.reactivex.rxjava3.subjects.ReplaySubject
import org.junit.Test

/**
 * @author junwang
 * @date 2024/07/04 23:05
 */
class RxJavaSubjectUnitTest {
    @Test
    fun publishSubjectTest() {
        //PublishSubject only emits to current subscribers.
        val publishSubject = PublishSubject.create<Int>()
        publishSubject.onNext(1)
        val subcriptionOne = publishSubject.subscribe {
            println(it)
        }
        publishSubject.onNext(2)
        val subscriptionTwo = publishSubject
            .subscribe {
                println("2)$it")
            }
        publishSubject.onNext(3)
        subcriptionOne.dispose()
        publishSubject.onNext(4)
        publishSubject.onComplete()
        publishSubject.onNext(5)
        subscriptionTwo.dispose()

        val subscriptionThree = publishSubject.subscribeBy(
            onNext = { println("3)$it") },
            onComplete = { println("3)Complete") }
        )

        publishSubject.onNext(6)
    }

    @Test
    fun behaviorSubjectTest() {
        //Behavior subjects work similarly to publish subjects, except they will replay the latest next event to new subscribers.
        val behaviorSubject = BehaviorSubject.create<Int>()
        val subscriptions = CompositeDisposable()
        behaviorSubject.onNext(1)
        val subcriptionOne = behaviorSubject.subscribe {
            println(it)
        }
        behaviorSubject.onNext(2)
        val subscriptionTwo = behaviorSubject
            .subscribe {
                println("2)$it")
            }
        behaviorSubject.onNext(3)
        subcriptionOne.dispose()
        behaviorSubject.onNext(4)
        behaviorSubject.onComplete()
        behaviorSubject.onNext(5)
        subscriptionTwo.dispose()

        behaviorSubject.onError(RuntimeException("Error!"))

        subscriptions.add(behaviorSubject.subscribeBy(
            onNext = { println("3)$it") },
            onError = { println("3)$it") },
            onComplete = { println("3)Complete") }
        ))

        behaviorSubject.onNext(6)
    }

    @Test
    fun replaySubjectTest() {
        //Replay subjects will temporarily cache — or buffer — the latest elements they emit, up to a specified size of your choosing. They will then replay that buffer to new subscribers.
        val replaySubject = ReplaySubject.createWithSize<String>(2)
        val subscriptions = CompositeDisposable()

        replaySubject.onNext("one")
        replaySubject.onNext("two")

        replaySubject.onNext("three")
        subscriptions.add(replaySubject.subscribeBy(
            onNext = { println("1)$it") },
            onError = { println("1)$it") }
        ))
        subscriptions.add(replaySubject.subscribeBy(
            onNext = { println("2)$it") },
            onError = { println("2)$it") }
        ))
        replaySubject.onNext("four")
        replaySubject.onError(RuntimeException("Error!"))

        subscriptions.add(replaySubject.subscribeBy(
            onNext = { println("3)$it") },
            onError = { println("3)$it") }
        ))


    }

    @Test
    fun asyncSubjectTest() {
        //An AsyncSubject will only ever emit the last value it received before it’s complete.
        // So if you pass several values into an AsyncSubject and then call onComplete on it, subscribers will only see the last value you passed into the subject and then a complete event. If the subject receives an error event, subscribers will see nothing!
        val asyncSubject = AsyncSubject.create<Int>()
        val subscription = CompositeDisposable()
        subscription.add(asyncSubject.subscribeBy(
            onNext = { println("$it") },
            onError = { println("$it") },
            onComplete = { println("Complete") }
        ))
        asyncSubject.onNext(1)
        asyncSubject.onNext(2)
        asyncSubject.onNext(3)
        asyncSubject.onComplete()
    }

    @Test
    fun neverTest() {
        val compositeDisposable = CompositeDisposable()
        val observer = Observable.never<Any>()
        compositeDisposable.add(observer.doOnNext { println(it) }.doOnComplete {
            println("doOnComplete")
        }.doOnSubscribe {
            println("doOnSubscribe")
        }
            .doOnDispose {
                println("doOnDispose")
            }
            .subscribeBy(onNext = {
                println(it)
            }, onComplete = {
                println("Complete")
            }))
        compositeDisposable.dispose()

    }
}