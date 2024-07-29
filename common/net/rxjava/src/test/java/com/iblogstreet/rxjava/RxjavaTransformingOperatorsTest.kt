package com.iblogstreet.rxjava

import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.disposables.CompositeDisposable
import io.reactivex.rxjava3.kotlin.subscribeBy
import io.reactivex.rxjava3.subjects.BehaviorSubject
import io.reactivex.rxjava3.subjects.PublishSubject
import kotlin.math.abs
import kotlin.test.Test


/**
 * @author junwang
 * @date 2024/07/29 22:55
 */
class RxjavaTransformingOperatorsTest {
    @Test
    fun listToTest() {
        val disposable = CompositeDisposable()

        disposable.add(Observable.just(1, 2, 3, 4, 5).toList().subscribeBy {
            println(it)
        })
    }

    @Test
    fun mapToTest() {
        val disposable = CompositeDisposable()
        disposable.add(Observable.just('A', 'B', 'C').map {
            it.code
        }.doOnError {
            println(it)
        }.subscribeBy {
            println(it)
        })
    }

    @Test
    fun flatMapTest() {
        val disposable = CompositeDisposable()
        val aStudent = Student(BehaviorSubject.createDefault(70))
        val bStudent = Student(BehaviorSubject.createDefault(80))
        val subject = PublishSubject.create<Student>()
        disposable.add(subject.flatMap { it.score }.subscribeBy {
            println(it)
        })
        subject.onNext(aStudent)
        aStudent.score.onNext(76)
        subject.onNext(bStudent)
        aStudent.score.onNext(90)

    }

    @Test
    fun switchMapTest() {
        val disposable = CompositeDisposable()
        val aStudent = Student(BehaviorSubject.createDefault(70))
        val bStudent = Student(BehaviorSubject.createDefault(80))
        val subject = PublishSubject.create<Student>()
        disposable.add(subject.switchMap { it.score }.subscribeBy {
            println(it)
        })
        subject.onNext(aStudent)
        aStudent.score.onNext(76)
        subject.onNext(bStudent)
        aStudent.score.onNext(90)
        bStudent.score.onNext(100)
    }

    @Test
    fun materializeOperatorTest() {
        val disposable = CompositeDisposable()
        val aStudent = Student(BehaviorSubject.createDefault(70))
        val bStudent = Student(BehaviorSubject.createDefault(80))
        val subject = PublishSubject.create<Student>()
        disposable.add(subject.switchMap { it.score.materialize() }.subscribeBy {
            println(it)
        })
        subject.onNext(aStudent)
        aStudent.score.onError(RuntimeException("break"))
        aStudent.score.onNext(76)

        subject.onNext(bStudent)
        bStudent.score.onNext(100)
    }

    @Test
    fun materializeAnddematerializeOperatorTest() {
        val disposable = CompositeDisposable()
        val aStudent = Student(BehaviorSubject.createDefault(70))
        val bStudent = Student(BehaviorSubject.createDefault(80))
        val subject = PublishSubject.create<Student>()
        disposable.add(subject.switchMap { it.score.materialize() }.filter {
            if (it.error != null) {
                false
            } else {
                true
            }
        }.dematerialize { it }.subscribeBy {
            println(it)
        })
        subject.onNext(aStudent)
        aStudent.score.onError(RuntimeException("break"))
        aStudent.score.onNext(76)

        subject.onNext(bStudent)
        bStudent.score.onNext(100)
    }
}