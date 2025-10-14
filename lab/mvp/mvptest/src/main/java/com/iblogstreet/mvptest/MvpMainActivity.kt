package com.iblogstreet.mvptest

import android.content.Context
import android.os.Bundle
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.FilledTonalButton
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import com.iblogstreet.mvp.BaseActivity
import com.iblogstreet.mvptest.bean.NewsBean
import com.iblogstreet.mvptest.ui.theme.AdvanceTheme

class MvpMainActivity : BaseActivity<MvpMainContract.Presenter>(), MvpMainContract.View {
    override val presenter: MvpMainContract.Presenter = MvpMainPresenter(this)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            val newsState = remember { mutableStateOf<NewsBean?>(null) }
            AdvanceTheme {
                Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
                    Column {
                        Title(
                            name = "MVP",
                            modifier = Modifier.padding(innerPadding)
                        )
                        ShowMeMessage(presenter = presenter, onNewsReceiver = {
                            newsState.value = it
                        })
                        Text(
                            text = "News: ${newsState.value?.toString() ?: "No News"}",
                        )
                    }

                }
            }
        }
    }

    override fun getContext(): Context {
        return this
    }
}

@Composable
fun ShowMeMessage(
    presenter: MvpMainContract.Presenter,
    onNewsReceiver: (NewsBean) -> Unit,
    modifier: Modifier = Modifier
) {
    FilledTonalButton(onClick = {
        presenter.loadNews { it ->
            onNewsReceiver(it)
        }
    }) {
        Text(text = "getNewsData", modifier = modifier)
    }
}

@Composable
fun Title(name: String, modifier: Modifier = Modifier) {
    Text(
        text = "Hello $name!",
        modifier = modifier
    )
}

@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    AdvanceTheme {
        Title("Android")
    }
}