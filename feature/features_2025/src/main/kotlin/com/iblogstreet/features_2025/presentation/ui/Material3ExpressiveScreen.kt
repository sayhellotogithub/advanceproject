package com.iblogstreet.features_2025.presentation.ui

import android.graphics.RenderEffect
import android.graphics.Shader
import android.os.Build
import android.os.Bundle
import androidx.activity.compose.setContent
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.animation.core.animateDpAsState
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.Typography
import androidx.compose.material3.dynamicLightColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.asComposeRenderEffect
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import dagger.hilt.android.AndroidEntryPoint

/**
 * @author junwang
 * @date 2025/05/28 18:16
 */
@AndroidEntryPoint
class Material3ExpressiveScreen : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            ExpressiveScreen()
        }
    }
}


@Composable
fun ExpressiveScreen() {
    val context = LocalContext.current
    val scrollState = rememberScrollState()

    // 動的カラー（Expressive)
    val colorScheme = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
        dynamicLightColorScheme(context)
    } else {
        lightColorScheme()
    }

    MaterialTheme(
        colorScheme = colorScheme,
        typography = Typography(
            displayLarge = TextStyle(
                fontSize = 48.sp,
                fontWeight = FontWeight.Bold,
                letterSpacing = 1.5.sp
            )
        )
    ) {
        Surface(modifier = Modifier.fillMaxSize(), color = MaterialTheme.colorScheme.background) {
            Column(
                modifier = Modifier
                    .verticalScroll(scrollState)
                    .fillMaxSize()
                    .padding(16.dp)
            ) {
                Text(
                    text = "Welcome to Expressive UI",
                    style = MaterialTheme.typography.displayLarge,
                    color = MaterialTheme.colorScheme.primary
                )

                Spacer(modifier = Modifier.height(24.dp))

                // アニメーション付きカード
                var expanded by remember { mutableStateOf(false) }
                val animatedSize by animateDpAsState(if (expanded) 200.dp else 100.dp)

                Card(
                    modifier = Modifier
                        .fillMaxWidth()
                        .height(animatedSize)
                        .clickable { expanded = !expanded },
                    elevation = CardDefaults.cardElevation(12.dp)
                ) {
                    Box(contentAlignment = Alignment.Center, modifier = Modifier.fillMaxSize()) {
                        Text("Tap to Animate", color = MaterialTheme.colorScheme.onSurface)
                    }
                }

                Spacer(modifier = Modifier.height(24.dp))
                BlurredBoxCompat()
            }
        }
    }
}

@Composable
fun BlurredBoxCompat() {
    if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) {
        // Fallback for older versions
        Box(
            modifier = Modifier
                .fillMaxWidth()
                .height(150.dp)
                .background(Color.White.copy(alpha = 0.4f)),
            contentAlignment = Alignment.Center
        ) {
            Text("ぼかし効果の例2", fontSize = 14.sp, color = Color.Black)
        }
    } else {
        BlurredBox()
    }
}

@RequiresApi(Build.VERSION_CODES.S)
@Composable
fun BlurredBox() {

    val blurEffect = remember {
        RenderEffect.createBlurEffect(20f, 20f, Shader.TileMode.CLAMP).asComposeRenderEffect()
    }
    Box(
        modifier = Modifier
            .fillMaxWidth()
            .height(150.dp)
            .graphicsLayer {
                renderEffect = blurEffect
            }
            .background(Color.White.copy(alpha = 0.4f)),
        contentAlignment = Alignment.Center
    ) {
        Text("ぼかし効果の例1", fontSize = 14.sp, color = Color.Black)
    }

    Spacer(modifier = Modifier.height(8.dp))
}
