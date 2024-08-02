package com.iblogstreet.rxjava

import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.disposables.CompositeDisposable
import io.reactivex.rxjava3.kotlin.addTo
import io.reactivex.rxjava3.kotlin.subscribeBy
import io.reactivex.rxjava3.subjects.PublishSubject
import kotlin.test.Test

/**
 * @author junwang
 * @date 2024/08/02 0:23
 */
class RxjavaCombiningOperatorsTest {
    @Test
    fun startWithTest() {
        val compositeDisposable = CompositeDisposable()
        val firstQueue = Observable.just(1, 2, 3)
        val combineSet = firstQueue.startWithIterable(listOf(-1, 0))
        compositeDisposable.add(combineSet.subscribeBy {
            println(it)
        })
    }

    @Test
    fun concatTest() {
        val compositeDisposable = CompositeDisposable()
        val firstQueue = Observable.just(1, 2, 3)
        val secondQueue = Observable.just(4, 5, 6)
        Observable.concat(firstQueue, secondQueue).subscribeBy {
            println(it)
        }.addTo(compositeDisposable)
    }

    @Test
    fun concatWithTest() {
        val compositeDisposable = CompositeDisposable()
        val firstQueue = Observable.just(1, 2, 3)
        val secondQueue = Observable.just(4, 5, 6)
        firstQueue.concatWith(secondQueue).subscribeBy {
            println(it)
        }.addTo(compositeDisposable)
    }

    @Test
    fun concatMapTest() {
        val compositeDisposable = CompositeDisposable()
        val counts = Observable.just(1, 2, 3)

        counts.concatMap {
            when (it) {
                1 -> Observable.just(101, 102, 103)
                2 -> Observable.just(202, 203, 204)
                else -> Observable.empty<Int>()
            }
        }.subscribeBy {
            println(it)
        }.addTo(compositeDisposable)
    }

    @Test
    fun mergeTest() {
        val compositeDisposable = CompositeDisposable()
        val firstQueue = PublishSubject.create<Int>()
        val secondQueue = PublishSubject.create<Int>()
        Observable.merge(firstQueue, secondQueue).subscribeBy { println(it) }
            .addTo(compositeDisposable)
        firstQueue.onNext(1)
        secondQueue.onNext(3)
        firstQueue.onNext(2)
        firstQueue.onNext(4)

    }

    @Test
    fun mergeWithTest() {
        val compositeDisposable = CompositeDisposable()
        val firstQueue = PublishSubject.create<Int>()
        val secondQueue = PublishSubject.create<Int>()
        firstQueue.mergeWith(secondQueue).subscribeBy { println(it) }
            .addTo(compositeDisposable)
        firstQueue.onNext(1)
        secondQueue.onNext(3)
        firstQueue.onNext(2)
        firstQueue.onNext(4)

    }

    @Test
    fun combineLatestTest() {
        val compositeDisposable = CompositeDisposable()
        val firstQueue = PublishSubject.create<Int>()
        val secondQueue = PublishSubject.create<Int>()
        Observable.combineLatest(firstQueue, secondQueue) { first, second ->
            "$first : $second"

        }.subscribeBy {
            println(it)
        }.addTo(compositeDisposable)

        firstQueue.onNext(1)
        firstQueue.onNext(2)
        secondQueue.onNext(3)
        secondQueue.onNext(4)
        firstQueue.onNext(5)

    }

    @Test
    fun zipTest() {
        val compositeDisposable = CompositeDisposable()
        val firstQueue = PublishSubject.create<Int>()
        val secondQueue = PublishSubject.create<Int>()
        Observable.zip(firstQueue, secondQueue) { first, second ->
            "$first : $second"

        }.subscribeBy {
            println(it)
        }.addTo(compositeDisposable)

        firstQueue.onNext(1)
        firstQueue.onNext(2)
        secondQueue.onNext(3)
        secondQueue.onNext(4)
        firstQueue.onNext(5)
    }

    @Test
    fun withLatestFromTest() {
        val compositeDisposable = CompositeDisposable()
        val button = PublishSubject.create<Unit>()
        val editText = PublishSubject.create<String>()

        button.withLatestFrom(editText) { _: Unit, value: String ->
            value

        }.subscribeBy {
            println(it)
        }.addTo(compositeDisposable)

        button.onNext(Unit)
        editText.onNext("a")
        editText.onNext("ab")
        button.onNext(Unit)
        button.onNext(Unit)
        editText.onNext("abc")

    }

    @Test
    fun sampleTest() {
        // You could have achieved the same behavior by adding a distinctUntilChanged to the withLatestFrom Observable,
        val compositeDisposable = CompositeDisposable()
        val button = PublishSubject.create<Unit>()
        val editText = PublishSubject.create<String>()

        editText.sample(button).subscribeBy {
            println(it)
        }.addTo(compositeDisposable)

        button.onNext(Unit)
        editText.onNext("a")
        editText.onNext("ab")
        button.onNext(Unit)
        button.onNext(Unit)
        editText.onNext("abc")
        button.onNext(Unit)
    }

    @Test
    fun ambTest() {
        //It has a few select practical applications, like connecting to redundant servers and sticking with the one that responds first.
        val compositeDisposable = CompositeDisposable()
        val left = PublishSubject.create<String>()
        val right = PublishSubject.create<String>()
        left.ambWith(right).subscribeBy {
            println(it)
        }.addTo(compositeDisposable)

        right.onNext("right 2")
        left.onNext("left 1")
        left.onNext("left 2")
    }

    @Test
    fun reduceTest() {
        val compositeDisposable = CompositeDisposable()
        val subscription = Observable.just(1, 2, 3, 4, 5)
        subscription.reduce(0) { a, b ->
            a + b

        }.subscribeBy {
            println(it)
        }.addTo(compositeDisposable)


    }

    @Test
    fun scanTest() {
        val compositeDisposable = CompositeDisposable()
        val subscription = Observable.just(1, 2, 3, 4, 5)
        subscription.scan { a, b ->
            a + b

        }.subscribeBy {
            println(it)
        }.addTo(compositeDisposable)
    }

    @Test
    fun zipCaseTest() {
        //Take the code from the scan example above and improve it so as to display both the current value and the running total at the same time.
        val compositeDisposable = CompositeDisposable()
        val source = Observable.just(1, 2, 3, 4, 5)

        val scanObservable = source.scan { a, b ->
            a + b
        }

        Observable.zip(source, scanObservable) { value, tatal ->
            value to tatal
        }.subscribeBy {
            println("value:${it.first},total:${it.second}")
        }.addTo(compositeDisposable)


        //second
        source.scan(0 to 0) { acc, current ->
            current to acc.second + current

        }.subscribeBy {
            println("second  value:${it.first},total:${it.second}")
        }.addTo(compositeDisposable)

    }

}