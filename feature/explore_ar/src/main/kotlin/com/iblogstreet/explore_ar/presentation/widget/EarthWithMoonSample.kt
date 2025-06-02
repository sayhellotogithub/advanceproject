package com.iblogstreet.explore_ar.presentation.widget

import android.util.Log
import androidx.compose.animation.core.Animatable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.systemBarsPadding
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
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.google.android.filament.Engine
import com.google.ar.core.Anchor
import com.google.ar.core.Config
import com.google.ar.core.Frame
import com.google.ar.core.TrackingFailureReason
import com.iblogstreet.explore_ar.R
import io.github.sceneview.ar.ARScene
import io.github.sceneview.ar.arcore.createAnchorOrNull
import io.github.sceneview.ar.arcore.isValid
import io.github.sceneview.ar.getDescription
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
import kotlinx.coroutines.delay
import kotlinx.coroutines.isActive
import kotlinx.coroutines.launch

/**
 * @author junwang
 * @date 2025/06/02 14:17
 */

@Composable
fun EarthWithMoonScene() {
    val engine = rememberEngine()
    val view = rememberView(engine)
    val cameraNode = rememberARCameraNode(engine)
    val modelLoader = rememberModelLoader(engine)
    val materialLoader = rememberMaterialLoader(engine)
    val collisionSystem = rememberCollisionSystem(view)
    val childNodes = rememberNodes()
    var planeRenderer by remember { mutableStateOf(true) }
    var trackingFailureReason by remember {
        mutableStateOf<TrackingFailureReason?>(null)
    }
    var frame by remember { mutableStateOf<Frame?>(null) }

    var anchorInstance = remember { mutableStateOf<Anchor?>(null) }

    anchorInstance.value?.let {
        childNodes += EarthWithMoonSample(
            engine = engine,
            modelLoader = modelLoader,
            anchor = it,
            materialLoader = materialLoader
        )
    }

    Box(modifier = Modifier.fillMaxSize()) {
        ARScene(
            modifier = Modifier.fillMaxSize(),
            engine = engine,
            view = view,
            cameraNode = cameraNode,
            modelLoader = modelLoader,
            materialLoader = materialLoader,
            collisionSystem = collisionSystem,
            childNodes = childNodes,
            planeRenderer = planeRenderer,
            sessionConfiguration = { session, config ->
                config.depthMode =
                    when (session.isDepthModeSupported(Config.DepthMode.AUTOMATIC)) {
                        true -> Config.DepthMode.AUTOMATIC
                        else -> Config.DepthMode.DISABLED
                    }
                config.instantPlacementMode = Config.InstantPlacementMode.LOCAL_Y_UP
                config.lightEstimationMode = Config.LightEstimationMode.ENVIRONMENTAL_HDR
                config.planeFindingMode = Config.PlaneFindingMode.HORIZONTAL_AND_VERTICAL
            },
            onSessionUpdated = { _, updatedFrame ->
                frame = updatedFrame

            },
            onGestureListener = rememberOnGestureListener(
                onSingleTapConfirmed = { motionEvent, _ ->
                    if (childNodes.isNotEmpty()) {
                        // 最大数に達している場合は何もしない
                        return@rememberOnGestureListener
                    }
                    // Create an anchor at the tapped position
                    val hitResult = frame?.hitTest(motionEvent.x, motionEvent.y)?.firstOrNull()
                    if (hitResult != null && hitResult.isValid()) {
                        planeRenderer = false
                        val anchor = hitResult.createAnchorOrNull()
                        if (anchor != null) {
                            anchorInstance.value = anchor
                        }
                    }
                }

            )
        )
        Text(
            modifier = Modifier
                .systemBarsPadding()
                .fillMaxWidth()
                .align(Alignment.TopCenter)
                .padding(top = 16.dp, start = 32.dp, end = 32.dp),
            textAlign = TextAlign.Center,
            fontSize = 28.sp,
            color = Color.White,
            text = trackingFailureReason?.let {
                it.getDescription(LocalContext.current)
            } ?: if (childNodes.isEmpty()) {
                stringResource(R.string.feature_explore_ar_point_your_phone_down)
            } else {
                stringResource(R.string.feature_explore_ar_tap_anywhere_to_add_model)
            }
        )
    }

    // クリーンアップ処理
    DisposableEffect(Unit) {
        onDispose {
            anchorInstance.value?.detach()
        }
    }

}

@Composable
fun EarthWithMoonSample(
    anchor: Anchor,
    engine: Engine,
    modelLoader: ModelLoader,
    materialLoader: MaterialLoader,
): AnchorNode {
    val anchorNode = remember { AnchorNode(engine, anchor) }

    val earthNode = remember {
        ModelNode(
            modelInstance = modelLoader.createModelInstance("models/feature_explore_ar_earth.glb"),
            scaleToUnits = 0.1f
        )
    }

    //月は地球の約１/4の大きさ
    val moonNode = remember {
        ModelNode(
            modelInstance = modelLoader.createModelInstance("models/feature_explore_ar_moon.glb"),
            scaleToUnits = 0.027f
        ).apply {
            position = Position(x = 0.3f, y = 0f, z = 0f)
        }
    }

    anchorNode.addChildNode(earthNode)
    anchorNode.addChildNode(moonNode)

    val earthRotation = remember { Animatable(0f) }
    val moonOrbitRotation = remember { Animatable(0f) }
    val moonSelfRotation = remember { Animatable(0f) }

    LaunchedEffect(Unit) {
        try {
            launch {
                while (isActive) {
                    earthRotation.snapTo((earthRotation.value + 1f) % 360f)
                    delay(16L)
                }
            }
            launch {
                while (isActive) {
                    moonOrbitRotation.snapTo((moonOrbitRotation.value + 1.5f) % 360f)
                    delay(16L)
                }
            }
            launch {
                while (isActive) {
                    moonSelfRotation.snapTo((moonSelfRotation.value + 1f) % 360f)  // 自転速度調整
                    delay(16L) // 60fps
                }
            }
        } catch (e: Exception) {
            Log.e("Animation", "Error during rotation animation", e)
        }
    }

    LaunchedEffect(earthRotation.value, moonOrbitRotation.value, moonSelfRotation.value) {
        earthNode.rotation = Rotation(y = -earthRotation.value)

        val radians = Math.toRadians(moonOrbitRotation.value.toDouble())
        val x = 0.3f * kotlin.math.cos(radians).toFloat()
        val z = 0.3f * kotlin.math.sin(radians).toFloat()
        moonNode.position = Position(x = x, y = 0f, z = z)

        moonNode.rotation = Rotation(y = moonSelfRotation.value)
    }
    val boundingBoxNode = CubeNode(
        engine,
        size = earthNode.extents,
        center = earthNode.center,
        materialInstance = materialLoader.createColorInstance(Color.White.copy(alpha = 0.5f))
    ).apply {
        isVisible = false
    }


    earthNode.onEditingChanged = { editing ->
        boundingBoxNode.isVisible = editing.isNotEmpty()
    }

    DisposableEffect(Unit) {
        onDispose {
            try {
                earthNode.destroy()
                moonNode.destroy()
                anchorNode.destroy()
            } catch (e: Exception) {
                Log.e("AR", "Cleanup error", e)
            }
        }
    }
    return anchorNode
}

