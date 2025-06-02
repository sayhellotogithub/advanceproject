package com.iblogstreet.explore_ar

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
import com.iblogstreet.explore_ar.presentation.ui.ExploreAREarthOrbitNodeWithAnimationScreen
import com.iblogstreet.explore_ar.presentation.ui.ExploreAREarthWithMoonScreen
import com.iblogstreet.explore_ar.presentation.ui.ExploreARSolarSystemScreen
import com.iblogstreet.explore_ar.presentation.ui.ExploreARViewSimpleScreen
import dagger.hilt.android.AndroidEntryPoint


/**
 * @author junwang
 * @date 2025/05/29 23:41
 */
@AndroidEntryPoint
class ExploreARMainScreen : AppCompatActivity() {

    companion object {
        @JvmStatic
        internal fun start(context: Context) {
            val intent = Intent(context, ExploreARMainScreen::class.java)
            context.startActivity(intent)
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            setContent {
                AppTheme {
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
                                PrimaryButton(buttonText = "explore ar vie ", buttonClick = {
                                    startActivity(
                                        Intent(
                                            this@ExploreARMainScreen,
                                            ExploreARViewSimpleScreen::class.java
                                        )
                                    )
                                })
                            }
                            item {
                                PrimaryButton(buttonText = "solor system", buttonClick = {
                                    startActivity(
                                        Intent(
                                            this@ExploreARMainScreen,
                                            ExploreARSolarSystemScreen::class.java
                                        )
                                    )
                                })
                            }
                            item {
                                PrimaryButton(buttonText = "earth", buttonClick = {
                                    startActivity(
                                        Intent(
                                            this@ExploreARMainScreen,
                                            ExploreAREarthOrbitNodeWithAnimationScreen::class.java
                                        )
                                    )
                                })
                            }
                            item {
                                PrimaryButton(buttonText = "earth and moon", buttonClick = {
                                    startActivity(
                                        Intent(
                                            this@ExploreARMainScreen,
                                            ExploreAREarthWithMoonScreen::class.java
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
}
