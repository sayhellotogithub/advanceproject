package com.iblogstreet.advance

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.paddingFromBaseline
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyHorizontalGrid
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.AccountCircle
import androidx.compose.material.icons.filled.Face
import androidx.compose.material.icons.filled.Icecream
import androidx.compose.material.icons.filled.Search
import androidx.compose.material.icons.filled.Spa
import androidx.compose.material3.Button
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.NavigationBar
import androidx.compose.material3.NavigationBarItem
import androidx.compose.material3.NavigationRail
import androidx.compose.material3.NavigationRailItem
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.material3.windowsizeclass.ExperimentalMaterial3WindowSizeClassApi
import androidx.compose.material3.windowsizeclass.WindowSizeClass
import androidx.compose.material3.windowsizeclass.WindowWidthSizeClass
import androidx.compose.material3.windowsizeclass.calculateWindowSizeClass
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.iblogstreet.advance.model.EntryType
import com.iblogstreet.advance.model.FunctionEntryModel
import com.iblogstreet.advance.util.data_util
import com.iblogstreet.advance.util.data_util.Companion.entryTypeList
import com.iblogstreet.designsystem.theme.AdvanceprojectTheme
import com.iblogstreet.login.expose.LoginExpose
import com.iblogstreet.photo.expose.PhotoExpose
import dagger.hilt.android.AndroidEntryPoint
import io.github.oshai.kotlinlogging.KotlinLogging
import javax.inject.Inject

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
            KotlinLogging.logger("1111 {${windowSizeClass.widthSizeClass}}")
            MainPage(windowSize = windowSizeClass)

//            AdvanceprojectTheme {
            // A surface container using the 'background' color from the theme
//                Surface(
//                    modifier = Modifier.fillMaxSize(), color = MaterialTheme.colorScheme.background
//                ) {

//                    Column(
//                        modifier = Modifier
//                            .fillMaxSize()
//                            .background(color = Color.Cyan),
//                        verticalArrangement = Arrangement.Center,
//                        horizontalAlignment = Alignment.CenterHorizontally
//                    ) {
//                        Button(onClick = {
//                            photoExpose.startPhotoActivity(this@MainActivity)
//                        }) {
//                            Text("Photo")
//                        }
//                        Button(onClick = {
//                            loginExpose.startLoginActivity(this@MainActivity)
//                        }) {
//                            Text("Login")
//                        }
//                    }


//                }
//            }
        }
    }
}

@Composable
fun SearchBar(modifier: Modifier = Modifier) {
    TextField(
        value = "",
        onValueChange = {},
        leadingIcon = {
            Icon(
                imageVector = Icons.Default.Search, contentDescription = null
            )
        },
        colors = TextFieldDefaults.colors(
            unfocusedContainerColor = MaterialTheme.colorScheme.surface,
            focusedContainerColor = MaterialTheme.colorScheme.surface
        ),
        placeholder = { Text(stringResource(id = R.string.placeholder_search)) }
    )
}

@Composable
fun FunctionEntryGrid(
    modifier: Modifier = Modifier
) {
    LazyHorizontalGrid(
        rows = GridCells.Fixed(2),
        contentPadding = PaddingValues(horizontal = 16.dp),
        horizontalArrangement = Arrangement.spacedBy(16.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp),
        modifier = modifier.height(80.dp)
    ) {
        items(count = entryTypeList.size) { index ->
            FunctionEntryCard(entryType = entryTypeList.get(index))

        }

    }
}

@Composable
fun FunctionEntryCard(
    entryType: FunctionEntryModel,
    modifier: Modifier = Modifier
) {
    Surface(
        shape = MaterialTheme.shapes.medium,
        color = MaterialTheme.colorScheme.surfaceVariant,
        modifier = modifier
    ) {
        Row(
            verticalAlignment = Alignment.CenterVertically,
            modifier = Modifier.width(255.dp)
        ) {
            if (entryType.entryType == EntryType.LOGIN) {
                Button(onClick = {
//                    photoExpose.startPhotoActivity(this@MainActivity)
                }, modifier = Modifier.size(80.dp)) {
                    Text(
                        "Photo", style = MaterialTheme.typography.titleMedium,
                        modifier = Modifier.padding(horizontal = 16.dp)
                    )
                }

            } else {
                Button(onClick = {
//                    photoExpose.startPhotoActivity(this@MainActivity)
                }, modifier = Modifier.size(80.dp)) {
                    Text(
                        "Login", style = MaterialTheme.typography.titleMedium,
                        modifier = Modifier.padding(horizontal = 16.dp)
                    )
                }
            }

        }
    }
}

@Composable
fun PhotoItem(modifier: Modifier = Modifier, text: String? = null) {
    Column(
        modifier = modifier,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Image(
            imageVector = Icons.Default.Face,
            contentDescription = null,
            contentScale = ContentScale.Crop,
            modifier = Modifier
                .size(88.dp)
                .clip(CircleShape)
        )
        Text(
            text = text ?: "",
            modifier = Modifier.paddingFromBaseline(top = 24.dp, bottom = 8.dp),
            style = MaterialTheme.typography.bodyMedium
        )
    }
}

@Composable
fun photoList(modifier: Modifier = Modifier) {
    LazyRow(
        horizontalArrangement = Arrangement.spacedBy(8.dp),
        contentPadding = PaddingValues(horizontal = 16.dp),
        modifier = modifier
    ) {
        items(data_util.photos.size) { item ->
            PhotoItem(text = data_util.photos.get(item))
        }
    }
}

@Composable
fun ItemSection(
    title: String? = null, modifier: Modifier = Modifier,
    content: @Composable () -> Unit
) {
    Column(modifier) {
        Text(
            text = title ?: "",
            style = MaterialTheme.typography.titleMedium,
            modifier = Modifier
                .paddingFromBaseline(top = 40.dp, bottom = 16.dp)
                .padding(horizontal = 16.dp)
        )
        content()
    }
}

@Composable
fun BottomNavBar(modifier: Modifier = Modifier) {
    NavigationBar(
        containerColor = MaterialTheme.colorScheme.surfaceVariant,
        modifier = modifier
    ) {
        NavigationBarItem(
            icon = {
                Icon(
                    imageVector = Icons.Default.Spa,
                    contentDescription = null
                )
            },
            label = {
                Text(stringResource(R.string.bottom_navigation_home))
            },
            selected = true,
            onClick = {}
        )
        NavigationBarItem(
            icon = {
                Icon(
                    imageVector = Icons.Default.AccountCircle,
                    contentDescription = null
                )
            },
            label = {
                Text(stringResource(R.string.bottom_navigation_mine))
            },
            selected = false,
            onClick = {}
        )
    }
}

@Composable
private fun HorizontalNavBar(modifier: Modifier = Modifier) {
    NavigationRail(
        modifier = modifier.padding(start = 8.dp, end = 8.dp),
        containerColor = MaterialTheme.colorScheme.background,
    ) {
        Column(
            modifier = modifier.fillMaxHeight(),
            verticalArrangement = Arrangement.Center,
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            NavigationRailItem(
                icon = {
                    Icon(
                        imageVector = Icons.Default.Spa,
                        contentDescription = null
                    )
                },
                label = {
                    Text(stringResource(R.string.bottom_navigation_home))
                },
                selected = true,
                onClick = {}
            )
            Spacer(modifier = Modifier.height(8.dp))
            NavigationRailItem(
                icon = {
                    Icon(
                        imageVector = Icons.Default.AccountCircle,
                        contentDescription = null
                    )
                },
                label = {
                    Text(stringResource(R.string.bottom_navigation_mine))
                },
                selected = false,
                onClick = {}
            )
        }
    }
}

@Composable
fun AppPortraitScape() {
    AdvanceprojectTheme {
        Scaffold(bottomBar = { BottomNavBar() }) { padding ->
            MainBodyContent(modifier = Modifier.padding(padding))
        }

    }
}

@Composable
fun MainBodyContent(modifier: Modifier = Modifier) {
    Column(
        modifier = Modifier.verticalScroll(rememberScrollState())
    ) {
        Spacer(Modifier.height(16.dp))
        SearchBar(Modifier.padding(horizontal = 16.dp))
        ItemSection(title = "photo") {
            photoList()
        }
        ItemSection(title = "function") {
            FunctionEntryGrid()
        }
        Spacer(Modifier.height(16.dp))
    }
}

@Composable
fun AppLandscape() {
    AdvanceprojectTheme {
        Row {
            HorizontalNavBar()
            MainBodyContent()
        }
    }
}

@Composable
fun MainPage(windowSize: WindowSizeClass) {
    KotlinLogging.logger("good {${windowSize.widthSizeClass}}")
    when (windowSize.widthSizeClass) {
        WindowWidthSizeClass.Compact -> {
            AppPortraitScape()
        }

        WindowWidthSizeClass.Expanded -> {
            AppLandscape()
        }
    }
}
//@Preview(showBackground = true, backgroundColor = 0xFFF5F0EE)
//@Composable
//fun GreetingPreview() {
////    MainPage(windowSize = windowSizeClass)
//}