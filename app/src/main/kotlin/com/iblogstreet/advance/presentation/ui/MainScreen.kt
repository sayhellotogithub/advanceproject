package com.iblogstreet.advance.presentation.ui

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.AccountCircle
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Person
import androidx.compose.material.icons.filled.Search
import androidx.compose.material.icons.filled.Spa
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.NavigationBar
import androidx.compose.material3.NavigationBarItem
import androidx.compose.material3.NavigationRail
import androidx.compose.material3.NavigationRailItem
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.windowsizeclass.WindowSizeClass
import androidx.compose.material3.windowsizeclass.WindowWidthSizeClass
import androidx.compose.runtime.Composable
import androidx.compose.runtime.MutableIntState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.currentBackStackEntryAsState
import androidx.navigation.compose.rememberNavController
import com.iblogstreet.advance.R
import com.iblogstreet.designsystem.theme.AppTheme
import com.iblogstreet.login.expose.LoginExpose
import com.iblogstreet.photo.expose.PhotoExpose

@Composable
fun MainScreen(windowSize: WindowSizeClass, loginExpose: LoginExpose, photoExpose: PhotoExpose) {

    when (windowSize.widthSizeClass) {
        WindowWidthSizeClass.Compact ->
            AppPortraitScape(loginExpose = loginExpose, photoExpose = photoExpose)

        WindowWidthSizeClass.Expanded ->
            AppLandscape(loginExpose = loginExpose, photoExpose = photoExpose)
    }

}

enum class BottomNavItem(val route: String, val icon: ImageVector, val label: String) {
    Home("home", Icons.Default.Home, "Home"),
    Search("widget", Icons.Default.Search, "Search"),
    Profile("profile", Icons.Default.Person, "Profile");
}

@Composable
fun BottomNavigationBar(
    modifier: Modifier = Modifier,
    navController: NavHostController,

) {
    val currentBackStackEntry by navController.currentBackStackEntryAsState()
    val currentRoute = currentBackStackEntry?.destination?.route

    NavigationBar(
        modifier = modifier,
        contentColor = MaterialTheme.colorScheme.onBackground
    ) {
        BottomNavItem.entries.forEach{ screen ->
            NavigationBarItem(
                icon = { Icon(screen.icon, contentDescription = screen.label) },
                label = { Text(screen.label) },

                selected = currentRoute == screen.route,
                onClick = {
                   if(currentRoute != screen.route) {
                       navController.navigate(screen.route) {
                           popUpTo(navController.graph.startDestinationId) {
                               saveState = true
                           }
                           launchSingleTop = true
                           restoreState = true
                       }
                   }
                }
            )
        }
    }
}


@Composable
fun AppPortraitScape(loginExpose: LoginExpose, photoExpose: PhotoExpose) {
    val navController = rememberNavController()

    AppTheme {
        Scaffold(
            bottomBar = {
                BottomNavigationBar(
                    navController = navController
                )
            }) { padding ->
            NavHost(
                navController = navController,
                startDestination = "home",
                modifier = Modifier
                    .padding(padding)

            ) {
                composable("home") {
                    HomeScreen(
                        modifier = Modifier.padding(padding),
                        loginExpose = loginExpose,
                        photoExpose = photoExpose
                    )
                }
                composable("widget") {
                    WidgetScreen()
                }
                composable("profile") {
                    ProfileScreen()
                }
            }


        }

    }
}


@Composable
fun AppLandscape(loginExpose: LoginExpose, photoExpose: PhotoExpose) {
    AppTheme {
        Row {
            HorizontalNavBar()
            HomeScreen(
                modifier = Modifier.padding(16.dp),
                loginExpose = loginExpose,
                photoExpose = photoExpose
            )
        }
    }
}

@Composable
fun HorizontalNavBar(modifier: Modifier = Modifier) {
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


//@Preview(showBackground = true, backgroundColor = 0xFFF5F0EE)
//@Composable
//fun GreetingPreview() {
////    MainPage(windowSize = windowSizeClass)
//}