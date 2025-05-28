package com.iblogstreet.features_2025

import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.activity.compose.setContent
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.ui.Modifier
import com.iblogstreet.designsystem.components.PrimaryButton
import com.iblogstreet.designsystem.theme.AppTheme
import com.iblogstreet.features_2025.presentation.ui.Material3ExpressiveScreen
import dagger.hilt.android.AndroidEntryPoint

/**
 * @author junwang
 * @date 2025/05/28 0:42
 */
@AndroidEntryPoint
class FeaturesMainActivity : AppCompatActivity() {

    companion object {
        @JvmStatic
        internal fun start(context: Context) {
            val intent = Intent(context, FeaturesMainActivity::class.java)
            context.startActivity(intent)
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            AppTheme {
                // A surface container using the 'background' color from the theme
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    PrimaryButton(buttonText = "Material3 Expressive", buttonClick = {
                        startActivity(Intent(this, Material3ExpressiveScreen::class.java))
                    })
                }
            }
        }

    }
}