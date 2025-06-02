package com.iblogstreet.explore_ar.presentation.ui

import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.activity.compose.setContent
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import com.iblogstreet.explore_ar.presentation.widget.EarthWithMoonSample
import com.iblogstreet.explore_ar.presentation.widget.EarthWithMoonScene
import com.iblogstreet.explore_ar.presentation.widget.rememberCameraPermissionState
import dagger.hilt.android.AndroidEntryPoint

/**
 * @author junwang
 * @date 2025/06/02 14:56
 */

@AndroidEntryPoint
class ExploreAREarthWithMoonScreen : AppCompatActivity() {

    companion object {
        @JvmStatic
        internal fun start(context: Context) {
            val intent = Intent(context, ExploreAREarthWithMoonScreen::class.java)
            context.startActivity(intent)
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            Surface(
                modifier = Modifier.fillMaxSize(),
                color = MaterialTheme.colorScheme.background
            ) {
                val context = LocalContext.current
                val (hasPermission, requestPermission) = rememberCameraPermissionState(context)

                LaunchedEffect(Unit) {
                    if (!hasPermission) requestPermission()
                }
                if (hasPermission) {
                    EarthWithMoonScene()
                } else {
                    AlertDialog(
                        onDismissRequest = { },
                        title = { Text("Camera Permission Required") },
                        text = { Text("This app requires camera permission to function properly.") },
                        confirmButton = {
                            TextButton(onClick = requestPermission) {
                                Text("Grant Permission")
                            }
                        }
                    )
                }
            }
        }
    }

}