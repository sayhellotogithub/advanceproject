package com.iblogstreet.advance

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import androidx.compose.material3.windowsizeclass.ExperimentalMaterial3WindowSizeClassApi
import androidx.compose.material3.windowsizeclass.calculateWindowSizeClass
import com.iblogstreet.advance.presentation.ui.MainScreen
import com.iblogstreet.advance.presentation.viewmodel.MainActivityViewModel
import com.iblogstreet.login.expose.LoginExpose
import com.iblogstreet.photo.expose.PhotoExpose
import dagger.hilt.android.AndroidEntryPoint
import io.github.oshai.kotlinlogging.KotlinLogging
import javax.inject.Inject

/**
 * @author junwang
 * @date 2025/05/13 17:26
 */
@AndroidEntryPoint
class MainActivity : ComponentActivity() {
    val viewModel: MainActivityViewModel by viewModels()

    @Inject
    lateinit var loginExpose: LoginExpose

    @Inject
    lateinit var photoExpose: PhotoExpose


    @OptIn(ExperimentalMaterial3WindowSizeClassApi::class)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            val windowSizeClass = calculateWindowSizeClass(this)
            KotlinLogging.logger("good {${windowSizeClass}}")
            MainScreen(windowSize = windowSizeClass,loginExpose = loginExpose, photoExpose = photoExpose)

        }
    }

}