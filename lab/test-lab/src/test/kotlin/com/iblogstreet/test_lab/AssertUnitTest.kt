package com.iblogstreet.test_lab

import org.assertj.core.api.Assertions.assertThat
import org.assertj.core.api.Assertions.assertThatThrownBy
import org.junit.jupiter.api.Test

/**
 * @author junwang
 * @date 2025/09/16 16:09
 */
class AssertUnitTest {
    @Test
    fun `assertJ assertions`() {
        assertThat("abc").isEqualTo("abc")
        assertThat("Android").startsWith("And")
        assertThat(listOf(1, 2, 3)).containsExactly(1, 2, 3)

        assertThatThrownBy {
            throw IllegalArgumentException("bad")
        }.isInstanceOf(IllegalArgumentException::class.java).hasMessageContaining("bad")
    }
}