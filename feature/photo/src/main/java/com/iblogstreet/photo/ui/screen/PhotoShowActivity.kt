package com.iblogstreet.photo.ui.screen

import android.os.Bundle
import android.widget.LinearLayout
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.magnifier
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Face
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material3.Button
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Constraints
import androidx.compose.ui.unit.dp
import androidx.constraintlayout.compose.ConstraintLayout
import com.iblogstreet.designsystem.theme.AdvanceprojectTheme
import com.iblogstreet.photo.Greeting
import com.iblogstreet.photo.R
import dagger.hilt.android.AndroidEntryPoint

/**
 * @author junwang
 * @date 2024/07/22 23:42
 */
@AndroidEntryPoint
class PhotoShowActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            AdvanceprojectTheme {
                // A surface container using the 'background' color from the theme
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {


                }
            }
        }
    }
}

@Composable
fun PhotoShowView() {
    ConstraintLayout(modifier = Modifier.fillMaxSize()) {
        Image(
            imageVector = Icons.Filled.Face,
            contentDescription = null,
            modifier = Modifier.height(240.dp)
        )
        Column {
            Button(onClick = {}) {
                Text("ADD")
            }
            Button(onClick = {}) {
                Text("CLEAR")
            }
            Button(onClick = {}) {
                Text("SAVE")
            }
        }

        Image(
            imageVector = Icons.Filled.Face, contentDescription = null,
            modifier = Modifier
                .height(75.dp)
                .width(100.dp)
        )

    }
}


@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    AdvanceprojectTheme {
        PhotoShowView()
    }
}