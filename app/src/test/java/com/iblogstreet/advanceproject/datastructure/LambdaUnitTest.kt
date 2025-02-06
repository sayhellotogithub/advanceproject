package com.iblogstreet.advanceproject.datastructure

import org.junit.Test

/**
 * @author junwang
 * @date 2025/02/06 10:42
 */
class LambdaUnitTest {
    @Test
    fun basicsLambdaTest() {
        val mulLambda: (Int, Int) -> Int = { a: Int, b: Int ->
            Int
            a * b
        }

        val mulLambda1: (Int, Int) -> Int = { a, b ->
            a * b
        }
        val squre: (Int) -> Int = { it * it }

    }

    fun operatorOnnumbers(a: Int, b: Int, operator: (Int, Int) -> Int): Int {

        return operator(a, b)
    }

    @Test
    fun argumentsLambdaTest() {
        operatorOnnumbers(1, 2, operator = { a, b -> a + b })
        val addLamdba = { a: Int, b: Int ->
            a + b
        }
        operatorOnnumbers(2, 3, operator = addLamdba)

        fun addFunction(a: Int, b: Int) = a + b
        operatorOnnumbers(2, 3, operator = ::addFunction)

        operatorOnnumbers(2, 3, operator = Int::plus)

    }

    @Test
    fun nothingLambda() {
        var nothingLambda: () -> Nothing = {
            throw NullPointerException()
        }
    }

    @Test
    fun countingLambda() {
        fun countingLambda(): () -> Int {
            var counter = 0
            val incrementCounter: () -> Int = {
                counter++
            }
            return incrementCounter

        }

        val counter1 = countingLambda()
        val counter2 = countingLambda()

        println(counter1())
        println(counter1())
        println(counter2())
        println(counter2())
        println(counter2())


    }


}