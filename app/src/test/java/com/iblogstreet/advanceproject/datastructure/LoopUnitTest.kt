package com.iblogstreet.advanceproject.datastructure

import org.junit.Test

/**
 * @author junwang
 * @date 2025/02/04 17:36
 */
class LoopUnitTest {
    @Test
    fun loopTest() {
        val closedRange = 0..5
        val halfOpenRange = 0 until 5
        val decreasingRange = 5 downTo 0

        val count = 10

        for (i in 0..5) {

        }

        repeat(5) {

        }

        for (i in 1..count step 2) {

        }

        for (i in count downTo 0 step 2) {

        }

    }

    @Test
    fun continueTest() {
        for (row in 1 until 8) {
            print("$row  ")
            if (row % 2 == 0) {
                println()
                continue
            }
            for (column in 1 until 8) {
                print("${row * column}  ")
            }
            println()
        }


    }

    @Test
    fun labeled_statements_useTest() {
        rowLoop@ for (row in 1 until 8) {
            print("$row  ")

            if (row % 2 == 0) {
                println()
                continue@rowLoop
            }
            columnLoop@ for (column in 1 until 8) {
                print("${row * column}  ")
            }
            println()

        }
    }
}