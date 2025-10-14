package com.iblogstreet.test_lab

import com.google.common.truth.Truth.assertThat
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.assertThrows

/**
 * @author junwang
 * @date 2025/09/16 16:09
 */
class TruthUnitTest {
    @Test
    fun `truth assertions`() {
        assertThat("abc").isEqualTo("abc")
        assertThat("Android").startsWith("And")

        assertThat(listOf(1, 2, 3)).containsExactly(1, 2, 3).inOrder()

        val e = assertThrows<IllegalArgumentException> {
            throw IllegalArgumentException("bad")
        }
        assertThat(e).hasMessageThat().contains("bad")


    }
}