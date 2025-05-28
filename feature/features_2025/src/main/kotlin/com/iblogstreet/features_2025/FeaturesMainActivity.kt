package com.iblogstreet.features_2025

import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.activity.compose.setContent
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.iblogstreet.designsystem.components.PrimaryButton
import com.iblogstreet.designsystem.theme.AppTheme
import com.iblogstreet.features_2025.presentation.ui.AndroidStudioCloudScreen
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
                    LazyColumn(
                        modifier = Modifier
                            .fillMaxSize()
                            .padding(vertical = 16.dp),
                        contentPadding = PaddingValues(horizontal = 16.dp, vertical = 8.dp),
                        verticalArrangement = Arrangement.spacedBy(12.dp)
                    ) {
                        item {
                            PrimaryButton(buttonText = "Go to Material3 Expressive", buttonClick = {
                                startActivity(
                                    Intent(
                                        this@FeaturesMainActivity,
                                        Material3ExpressiveScreen::class.java
                                    )
                                )
                            })
                        }
                        item {
                            PrimaryButton(buttonText = "Go to Android Studio Cloud", buttonClick = {
                                startActivity(
                                    Intent(
                                        this@FeaturesMainActivity,
                                        AndroidStudioCloudScreen::class.java
                                    )
                                )
                            })
                        }
                    }

                }
            }
        }

    }
}