package com.iblogstreet.advanceproject.datastructure

import org.junit.Test

/**
 * @author junwang
 * @date 2025/02/03 18:18
 */

class PairTupleUnitTest {

    @Test
    fun pairTest() {
        val coordinates: Pair<Int, String> = Pair(2, "two")
        val coordinateInferred = Pair(2, 3)
        //more concise より簡潔
        val coordinateWithTo = 2 to 3
        //access the data inside a pair
        coordinates.first
        val (x, y) = coordinates
    }

    @Test
    fun tripleTest() {
        val cooridinate3D = Triple(2, 4, 2025)

        //access the data inside a triple
        val (month, day, year) = cooridinate3D
        cooridinate3D.first
        val (month1, _, _) = cooridinate3D
    }

}