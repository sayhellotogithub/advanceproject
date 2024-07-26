package com.iblogstreet.photo.ui.screen

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.provider.CalendarContract
import android.widget.LinearLayout
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Image
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.magnifier
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Face
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material.icons.filled.Flag
import androidx.compose.material3.Button
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Constraints
import androidx.compose.ui.unit.dp
import androidx.constraintlayout.compose.ConstraintLayout
import com.iblogstreet.designsystem.theme.AppTheme
import com.iblogstreet.photo.R
import dagger.hilt.android.AndroidEntryPoint

/**
 * @author junwang
 * @date 2024/07/22 23:42
 */
@AndroidEntryPoint
class PhotoShowActivity : ComponentActivity() {
    companion object {
        internal fun start(context: Context) {
            context.startActivity(Intent(context, PhotoShowActivity::class.java))
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            AppTheme {
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
        val (collageImage, col, thumbnail) = createRefs()

        Image(
            imageVector = Icons.Filled.Face,
            contentDescription = null,
            contentScale = ContentScale.Crop,
            modifier = Modifier
                .constrainAs(collageImage) {
                    top.linkTo(parent.top, margin = 0.dp)

                    centerVerticallyTo(parent)
                    centerHorizontallyTo(parent)
                }
                .border(width = 2.dp, color = Color.Red)
                .height(240.dp)
        )
        Row(modifier = Modifier.constrainAs(col) {
            top.linkTo(collageImage.bottom, margin = 10.dp)
            centerHorizontallyTo(collageImage)
        }) {
            Button(onClick = {}) {
                Text(stringResource(R.string.feature_photo_add))
            }
            Spacer(modifier = Modifier.width(10.dp))

            Button(onClick = {}) {
                Text(stringResource(R.string.feature_photo_clear))
            }
            Spacer(modifier = Modifier.width(10.dp))
            Button(onClick = {}) {
                Text(stringResource(R.string.feature_photo_save))
            }
        }

        Image(
            imageVector = Icons.Filled.Flag, contentDescription = null,
            modifier = Modifier
                .constrainAs(thumbnail) {
                    top.linkTo(col.bottom, margin = 32.dp)
                    centerHorizontallyTo(col)
                }
                .height(75.dp)
                .width(100.dp)
        )

    }
}


@Preview(showBackground = true)
@Composable
fun GreetingPreview() {


    AppTheme {
        Surface(
            modifier = Modifier.fillMaxSize(),
            color = Color.Gray
        ) {
            PhotoShowView()
        }
    }
}