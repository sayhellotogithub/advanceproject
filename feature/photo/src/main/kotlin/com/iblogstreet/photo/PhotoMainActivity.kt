package com.iblogstreet.photo

import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.iblogstreet.designsystem.theme.AppTheme
import com.iblogstreet.login.expose.LoginExpose
import dagger.hilt.android.AndroidEntryPoint
import javax.inject.Inject

@AndroidEntryPoint
class PhotoMainActivity : ComponentActivity() {
    companion object {
        @JvmStatic
        internal fun start(context: Context) {
            val intent = Intent(context, PhotoMainActivity::class.java)
            context.startActivity(intent)
        }
    }

    @Inject
    lateinit var loginExpose: LoginExpose


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            AppTheme {
                // A surface container using the 'background' color from the theme
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    Column(
                        modifier = Modifier
                            .fillMaxSize()
                            .background(color = Color.Cyan),
                        verticalArrangement = Arrangement.Center,
                        horizontalAlignment = Alignment.CenterHorizontally
                    ) {
                        Text(text = "This page is photo")
                        Button(onClick = {
                            finish()
                        }) {
                            Text("back")
                        }
                        Button(onClick = {
                            loginExpose.startLoginActivity(context = this@PhotoMainActivity)
                        }) {
                            Text("to Login")
                        }
                        Button(onClick = {
                            PhotoMainActivity.start(this@PhotoMainActivity)
                        }) {
                            Text("to PhotoOp")
                        }
                    }


                }
            }
        }
    }
}

@Composable
fun Greeting(name: String, modifier: Modifier = Modifier) {
    Text(
        text = "Hello $name!",
        modifier = modifier
    )
}

@Composable
fun HelloMain() {
    var name by rememberSaveable { mutableStateOf("") }
    HelloContent(name, onchange = {
        name=it
    })
}

@Composable
fun HelloContent(name: String,onchange:(String)->Unit) {
    Column(modifier = Modifier.padding(16.dp)) {

        if(name.isNotEmpty()) {
            Text(
                text = "Hello! $name",
                modifier = Modifier.padding(bottom = 8.dp),
                style = MaterialTheme.typography.bodyMedium
            )
        }
        OutlinedTextField(
            value = name,
            onValueChange = { onchange(it)},
            label = { Text("Name") }
        )
    }

}

@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    AppTheme {
        HelloMain()
    }
}
