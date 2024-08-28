package com.iblogstreet.rxjavatest.ui.time

import android.content.Intent
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material3.Button
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.ui.Modifier
import com.iblogstreet.designsystem.theme.AppTheme
import com.raywenderlich.android.timeoperators.DelayActivity
import com.raywenderlich.android.timeoperators.ReplayActivity
import com.raywenderlich.android.timeoperators.TimeoutActivity
import com.raywenderlich.android.timeoperators.WindowActivity

class TimeActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            AppTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    LazyColumn {

                        item {
                            Button(onClick = {
                                val intent = Intent(this@TimeActivity, ReplayActivity::class.java)
                                startActivity(intent)
                            }) {
                                Text("replay")
                            }
                        }
                        item {
                            Button(onClick = {
                                val intent = Intent(this@TimeActivity, WindowActivity::class.java)
                                startActivity(intent)
                            }) {
                                Text("windowed")
                            }
                        }
                        item {
                            Button(onClick = {
                                val intent = Intent(this@TimeActivity, DelayActivity::class.java)
                                startActivity(intent)
                            }) {
                                Text("delay")
                            }
                        }
                        item {
                            Button(onClick = {
                                val intent = Intent(this@TimeActivity, TimeoutActivity::class.java)
                                startActivity(intent)
                            }) {
                                Text("Timeout")
                            }
                        }


                    }


                }

            }
        }

    }


}
