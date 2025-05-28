package com.iblogstreet.features_2025.presentation.ui

import android.content.Intent
import android.os.Bundle
import androidx.activity.compose.setContent
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.ui.Modifier
import com.iblogstreet.designsystem.components.PrimaryButton
import com.iblogstreet.designsystem.components.SecureWebView
import com.iblogstreet.designsystem.theme.AppTheme
import dagger.hilt.android.AndroidEntryPoint

/**
 * @author junwang
 * @date 2025/05/29 0:25
 */
@AndroidEntryPoint
class AndroidStudioCloudScreen : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            AppTheme {
                // A surface container using the 'background' color from the theme
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    SecureWebView(url = "https://developer.android.com/studio/preview/android-studio-cloud?hl=ja", onError = {
                        it.printStackTrace()
                    }, onPageStarted = {
                        // ページ読み込み開始時の処理
                    }, onPageFinished = {
                        // ページ読み込み完了時の処理
                    })

                }
            }
        }
    }
}