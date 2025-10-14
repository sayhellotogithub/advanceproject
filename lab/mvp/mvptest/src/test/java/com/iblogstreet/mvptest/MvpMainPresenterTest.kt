package com.iblogstreet.mvptest

import junit.framework.TestCase.assertEquals
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.test.setMain
import org.junit.After
import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import org.mockito.junit.MockitoJUnitRunner

import org.junit.runner.RunWith

/**
 * @author junwang
 * @date 2025/02/17 14:20
 */
@RunWith(MockitoJUnitRunner::class)
class MvpMainPresenterTest {

    @Mock
    private lateinit var mockMainActivity: MvpMainContract.View

    private lateinit var presenter: MvpMainPresenter

    @Before
    fun setUp() {
        Dispatchers.setMain(Dispatchers.Unconfined)
        MockitoAnnotations.openMocks(this)
        presenter = MvpMainPresenter(mockMainActivity)
    }

    @After
    fun tearDown() {
        presenter.detachView()
    }

    @Test
    fun testOnViewCreatedFlow() {
        presenter.loadNews { news ->
            assertEquals("001", news.newId)
            assertEquals("Brown", news.author)
            assertEquals("2025-02-02", news.publicDate)
        }

    }

}