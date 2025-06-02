package com.iblogstreet.advance

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import androidx.compose.material3.windowsizeclass.ExperimentalMaterial3WindowSizeClassApi
import androidx.compose.material3.windowsizeclass.calculateWindowSizeClass
import com.iblogstreet.advance.domain.model.EntryType
import com.iblogstreet.advance.presentation.ui.MainScreen
import com.iblogstreet.advance.presentation.viewmodel.MainActivityViewModel
import com.iblogstreet.explore_ar.expose.ExploreArExpose
import com.iblogstreet.features_2025.expose.FeaturesExpose
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

    @Inject
    lateinit var featuresExpose: FeaturesExpose

    @Inject
    lateinit var exploreArExpose: ExploreArExpose


    @OptIn(ExperimentalMaterial3WindowSizeClassApi::class)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            val windowSizeClass = calculateWindowSizeClass(this)
            KotlinLogging.logger("good {${windowSizeClass}}")
            MainScreen(windowSize = windowSizeClass, callBack = { type: EntryType ->
                when (type) {
                    EntryType.LOGIN -> loginExpose.startLoginActivity(this)
                    EntryType.PHOTO -> photoExpose.startPhotoActivity(this)
                    EntryType.FEATURES -> featuresExpose.startFeaturesMainActivity(this)
                    EntryType.EXPLORE_AR -> exploreArExpose.startExploreArMainScreen(this)
                    else -> {

                    }
                }

            })

        }
    }

}