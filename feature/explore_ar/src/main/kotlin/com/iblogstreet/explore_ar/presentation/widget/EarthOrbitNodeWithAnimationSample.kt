package com.iblogstreet.explore_ar.presentation.widget

import androidx.compose.animation.core.Animatable
import androidx.compose.animation.core.LinearEasing
import androidx.compose.animation.core.RepeatMode
import androidx.compose.animation.core.infiniteRepeatable
import androidx.compose.animation.core.tween
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.systemBarsPadding
import androidx.compose.material3.Button
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.google.android.filament.Engine
import com.google.ar.core.Anchor
import com.google.ar.core.Config
import com.google.ar.core.Frame
import com.google.ar.core.TrackingState
import io.github.sceneview.ar.ARScene
import io.github.sceneview.ar.arcore.createAnchorOrNull
import io.github.sceneview.ar.arcore.isValid
import io.github.sceneview.ar.node.AnchorNode
import io.github.sceneview.ar.rememberARCameraNode
import io.github.sceneview.loaders.MaterialLoader
import io.github.sceneview.loaders.ModelLoader
import io.github.sceneview.math.Position
import io.github.sceneview.math.Rotation
import io.github.sceneview.node.CubeNode
import io.github.sceneview.node.ModelNode
import io.github.sceneview.rememberCollisionSystem
import io.github.sceneview.rememberEngine
import io.github.sceneview.rememberMaterialLoader
import io.github.sceneview.rememberModelLoader
import io.github.sceneview.rememberNodes
import io.github.sceneview.rememberOnGestureListener
import io.github.sceneview.rememberView
import kotlinx.coroutines.isActive
import kotlinx.coroutines.launch

/**
 * @author junwang
 * @date 2025/05/30 21:23
 */

data class EarthOrbitInstance(
    val anchor: Anchor,
    val systemIndex: Int,
    val id: String = java.util.UUID.randomUUID().toString()
)

@Composable
fun EarthOrbitNodeWithAnimationSample() {
    val context = LocalContext.current
    val engine = rememberEngine()
    val modelLoader = rememberModelLoader(engine)
    val materialLoader = rememberMaterialLoader(engine)
    val cameraNode = rememberARCameraNode(engine)
    val view = rememberView(engine)
    val collisionSystem = rememberCollisionSystem(view)
    val childNodes = rememberNodes()

    var frame by remember { mutableStateOf<Frame?>(null) }
    var trackingState by remember { mutableStateOf<TrackingState?>(null) }
    var solarSystems by remember { mutableStateOf<List<EarthOrbitInstance>>(emptyList()) }
    val maxSolarSystems = 5 // 最大数制限

    // アンカーノードの作成（メモリ安全版）
    solarSystems.forEach { solarSystem ->
        childNodes += MemorySafeSolarSystemNode(
            engine = engine,
            modelLoader = modelLoader,
            materialLoader = materialLoader,
            solarSystem = solarSystem
        )
    }

    // クリーンアップ処理
    DisposableEffect(Unit) {
        onDispose {
            // すべてのアンカーを適切に破棄
            solarSystems.forEach { it.anchor.detach() }
        }
    }


    Box(modifier = Modifier.fillMaxSize()) {
        ARScene(
            modifier = Modifier.fillMaxSize(),
            childNodes = childNodes,
            engine = engine,
            view = view,
            modelLoader = modelLoader,
            cameraNode = cameraNode,
            collisionSystem = collisionSystem,
            sessionConfiguration = { session, config ->
                config.depthMode = if (session.isDepthModeSupported(Config.DepthMode.AUTOMATIC)) {
                    Config.DepthMode.AUTOMATIC
                } else {
                    Config.DepthMode.DISABLED
                }
                config.instantPlacementMode = Config.InstantPlacementMode.LOCAL_Y_UP
                config.lightEstimationMode = Config.LightEstimationMode.ENVIRONMENTAL_HDR
                config.planeFindingMode = Config.PlaneFindingMode.HORIZONTAL_AND_VERTICAL
            },
            onSessionUpdated = { _, updatedFrame ->
                frame = updatedFrame
                trackingState = updatedFrame.camera.trackingState
            },
            onGestureListener = rememberOnGestureListener(
                onSingleTapConfirmed = { motionEvent, _ ->
                    if (solarSystems.size < maxSolarSystems) {
                        val hit = frame?.hitTest(motionEvent.x, motionEvent.y)
                            ?.firstOrNull { it.isValid(depthPoint = false, point = false) }
                        val anchor = hit?.createAnchorOrNull()
                        if (anchor != null) {
                            val newSystem = EarthOrbitInstance(
                                anchor = anchor,
                                systemIndex = solarSystems.size
                            )
                            solarSystems = solarSystems + newSystem
                        }
                    }
                }
            )
        )

        // ヘルプテキスト
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .align(Alignment.TopCenter)
                .padding(16.dp)
                .systemBarsPadding()
        ) {
            // Tracking status
            Text(
                text = when (trackingState) {
                    TrackingState.TRACKING -> "✓ AR Tracking Active"
                    TrackingState.PAUSED -> "⏸ AR Tracking Paused"
                    TrackingState.STOPPED -> "⚠ AR Tracking Lost"
                    else -> "🔍 Initializing AR..."
                },
                color = when (trackingState) {
                    TrackingState.TRACKING -> Color.Green
                    else -> Color.Yellow
                },
                fontSize = 14.sp,
                textAlign = TextAlign.Center,
                modifier = Modifier.fillMaxWidth()
            )

            // Help text
            Text(
                text = "太陽系を配置するには画面をタップ\n配置済み: ${solarSystems.size}/$maxSolarSystems 個",
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(top = 8.dp),
                textAlign = TextAlign.Center,
                color = Color.White,
                fontSize = 16.sp
            )
            // クリアボタン
            if (solarSystems.isNotEmpty()) {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(top = 8.dp)
                ) {
                    Button(
                        onClick = {
                            // 最後のアンカーを削除
                            val lastSystem = solarSystems.lastOrNull()
                            if (lastSystem != null) {
                                lastSystem.anchor.detach()
                                solarSystems = solarSystems.dropLast(1)
                            }
                        },
                        modifier = Modifier
                            .weight(1f)
                            .padding(end = 4.dp)
                    ) {
                        Text("最後を削除")
                    }

                    Button(
                        onClick = {
                            // 全てのアンカーを適切に破棄
                            solarSystems.forEach { it.anchor.detach() }
                            solarSystems = emptyList()
                        },
                        modifier = Modifier
                            .weight(1f)
                            .padding(start = 4.dp)
                    ) {
                        Text("全て削除")
                    }
                }
            }
        }
    }
}

@Composable
fun MemorySafeSolarSystemNode(
    engine: Engine,
    modelLoader: ModelLoader,
    materialLoader: MaterialLoader,
    solarSystem: EarthOrbitInstance
): AnchorNode {
    val anchorNode = remember(solarSystem.id) {
        AnchorNode(engine, solarSystem.anchor)
    }

    // モデル選択
    val selectedModel = remember(solarSystem.id) {
        solarSystemModels[solarSystem.systemIndex % solarSystemModels.size]
    }

    // メインモデルノード
    val modelNode = remember(solarSystem.id) {
        ModelNode(
            modelInstance = modelLoader.createModelInstance(selectedModel),
            scaleToUnits = 1.0f + (solarSystem.systemIndex * 0.2f)
        ).apply {
            isEditable = true
            editableScaleRange = 0.3f..3.0f
        }
    }

    // バウンディングボックス
    val boundingBoxNode = remember(solarSystem.id) {
        CubeNode(
            engine,
            size = modelNode.extents,
            center = modelNode.center,
            materialInstance = materialLoader.createColorInstance(
                Color.Cyan.copy(alpha = 0.4f)
            )
        ).apply {
            isVisible = false
        }
    }

    // アニメーション値
    val orbitRotation = remember(solarSystem.id) { Animatable(0f) }
    val selfRotation = remember(solarSystem.id) { Animatable(0f) }
//    val floatAnimation = remember(solarSystem.id) { Animatable(0f) }

    // メモリ安全なアニメーション設定
    LaunchedEffect(solarSystem.id) {
        launch {
            // 軌道回転
            while (isActive) { // isActiveチェックでメモリリーク防止
                try {
                    orbitRotation.animateTo(
                        targetValue = orbitRotation.value+360f,
                        animationSpec = infiniteRepeatable(
                            animation = tween(
                                durationMillis = 15000 + (solarSystem.systemIndex * 5000),
                                easing = LinearEasing
                            ),
                            repeatMode = RepeatMode.Restart
                        )
                    )
                } catch (e: Exception) {
                    break // アニメーション中断時に安全に終了
                }
            }
        }
        launch {
            // 自転
            while (isActive) {
                try {
                    selfRotation.animateTo(
                        targetValue = selfRotation.value + 360f,
                        animationSpec = tween(5000, easing = LinearEasing)
                    )
                } catch (e: Exception) {
                    break
                }
            }
        }
//        launch {
//            // 浮遊アニメーション
//            while (isActive) {
//                try {
//                    floatAnimation.animateTo(
//                        targetValue = 0.1f,
//                        animationSpec = tween(2000, easing = LinearEasing)
//                    )
//                    floatAnimation.animateTo(
//                        targetValue = -0.1f,
//                        animationSpec = tween(2000, easing = LinearEasing)
//                    )
//                } catch (e: Exception) {
//                    break
//                }
//            }
//        }
    }
    LaunchedEffect(selfRotation.value) {
        try {
            modelNode.rotation = Rotation(
                x = 0f,
                y = selfRotation.value, // Y軸回転がよく使われる（地球の自転っぽい）
                z = 0f
            )
        } catch (e: Exception) {
            // 破棄済みの可能性
        }
    }

    // アニメーション適用
//    LaunchedEffect(orbitRotation.value, selfRotation.value, floatAnimation.value) {
//        try {
//            modelNode.rotation = Rotation(
//                x = selfRotation.value * 0.3f,
//                y = orbitRotation.value,
//                z = selfRotation.value * 0.1f
//            )
//            modelNode.position = Position(
//                x = 0f,
//                y = floatAnimation.value,
//                z = 0f
//            )
//        } catch (e: Exception) {
//            // モデルが破棄済みの場合のエラーハンドリング
//        }
//    }

    // 編集モード
    modelNode.onEditingChanged = { editing ->
        boundingBoxNode.isVisible = editing.isNotEmpty()
    }

    // ノード階層構築
    modelNode.addChildNode(boundingBoxNode)
    anchorNode.addChildNode(modelNode)

    // クリーンアップ処理
    DisposableEffect(solarSystem.id) {
        onDispose {
            try {
                // リソースの適切な解放
                modelNode.destroy()
                boundingBoxNode.destroy()
                solarSystem.anchor.detach()
                anchorNode.destroy()
            } catch (e: Exception) {
                // 既に破棄済みの場合のエラーを無視
            }
        }
    }

    return anchorNode
}


private val solarSystemModels = listOf(
    "models/feature_explore_ar_earth.glb"
    // 追加のバリエーション:
    // "models/solar_system_variant_1.glb",
    // "models/solar_system_variant_2.glb"
)
