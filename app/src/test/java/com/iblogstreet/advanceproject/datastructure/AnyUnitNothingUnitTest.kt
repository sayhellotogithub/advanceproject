package com.iblogstreet.advanceproject.datastructure

import org.junit.Test

/**
 * @author junwang
 * @date 2025/02/04 15:59
 */
class AnyUnitNothingUnitTest {

    /** The Any type can be thought of as the mother of all other types (except nullable types)**/
    @Test
    fun anyTest() {
        val anyNumber: Any = 100
        val anyString: Any = "229"
    }

    /**
     * Unit is a special type which only ever represents one value: the Unit object. It is similar to the void type in Java
     *The return type Unit is implied
     * **/
    @Test
    fun unitTest() {
        val result = 1
        println(result)
    }

    /**
     * Nothing is a type that is helpful for declaring that a function not only doesn’t return anything, but also never completes.
     */

    @Test
    fun nothingTest() {
        doNothing()
    }

    fun doNothing(): Nothing {
        while (true) {

        }
    }
    
}