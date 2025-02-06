package com.iblogstreet.advanceproject.datastructure

import org.junit.Test

/**
 * @author junwang
 * @date 2025/02/06 17:39
 */
class AnonymousUnitTest {
    @Test
    fun anonymousInterfaceTest() {
        val count = object : Counts {
            override fun studentCount(): Int {
                return 1
            }

            override fun teacherCount(): Int {
                return 1
            }

        }
        val checker = object : ThresholdChecker {
            override val lower: Int
                get() = 7
            override val upper: Int
                get() = 10

            override fun isLit(value: Int): Boolean {
            }

            override fun tooQuiet(value: Int): Boolean {
            }
        }
    }

    interface Counts {
        fun studentCount(): Int
        fun teacherCount(): Int
    }

    interface ThresholdChecker {
        val lower: Int
        val upper: Int

        /**
         * Returns true if value is higher than the upper threshold
         * and false otherwise
         */
        fun isLit(value: Int): Boolean {
            return value > upper
        }

        /**
         * Returns true if value is less than the lower threshold
         * and false otherwise
         */
        fun tooQuiet(value: Int): Boolean = value < lower
    }
}