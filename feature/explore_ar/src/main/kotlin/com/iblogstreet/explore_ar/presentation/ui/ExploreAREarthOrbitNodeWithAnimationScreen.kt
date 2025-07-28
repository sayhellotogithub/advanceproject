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
import com.iblogstreet.ui.theme.AppTheme
import com.iblogstreet.explore_ar.presentation.widget.EarthOrbitNodeWithAnimationSample
import com.iblogstreet.explore_ar.presentation.widget.rememberCameraPermissionState
import dagger.hilt.android.AndroidEntryPoint

/**
 * @author junwang
 * @date 2025/05/30 21:43
 */
@AndroidEntryPoint
class ExploreAREarthOrbitNodeWithAnimationScreen : AppCompatActivity() {
    companion object {
        @JvmStatic
        internal fun start(context: Context) {
            val intent = Intent(context, ExploreAREarthOrbitNodeWithAnimationScreen::class.java)
            context.startActivity(intent)
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
                    val context = LocalContext.current
                    val (hasPermission, requestPermission) = rememberCameraPermissionState(context)

                    LaunchedEffect(Unit) {
                        if (!hasPermission) requestPermission()
                    }
                    if (!hasPermission) {
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
                    } else {
                        EarthOrbitNodeWithAnimationSample()
                    }
                }

            }
        }

    }

}