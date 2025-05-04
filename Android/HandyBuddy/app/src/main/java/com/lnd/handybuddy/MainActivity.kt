package com.lnd.handybuddy

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.Assignment
import androidx.compose.material.icons.filled.Assignment
import androidx.compose.material.icons.filled.ChatBubble
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material.icons.filled.PersonPin
import androidx.compose.material.icons.filled.Search
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.NavigationBar
import androidx.compose.material3.NavigationBarItem
import androidx.compose.material3.Icon
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.navigation.compose.rememberNavController
import com.lnd.handybuddy.ui.navigation.Screen
import com.lnd.handybuddy.ui.theme.HandyBuddyTheme
import com.lnd.handybuddy.ui.navigation.NavigationGraph
import androidx.navigation.NavHostController
import androidx.navigation.compose.currentBackStackEntryAsState


data class BottomNavItem(
    val name: String,
    val route: String,
    val icon: ImageVector
)

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            HandyBuddyTheme {
                val navController = rememberNavController()
                val items = listOf(
                    BottomNavItem("Find", Screen.Search.route, Icons.Filled.Search),
                    BottomNavItem("Chat", Screen.Chat.route, Icons.Filled.ChatBubble),
                    BottomNavItem("Saved", Screen.Saved.route, Icons.Filled.Favorite),
                    BottomNavItem("History", Screen.History.route, Icons.AutoMirrored.Filled.Assignment),
                    BottomNavItem("Profile", Screen.Profile.route, Icons.Filled.PersonPin)
                )

                Scaffold(
                    bottomBar = {
                        BottomNavigationBar(
                            items = items,
                            navController = navController
                        )
                    }
                ) { innerPadding ->
                    Box(modifier = Modifier.padding(innerPadding)) {
                        NavigationGraph(navController = navController)
                    }
                }
            }
        }
    }

    @Composable
    fun BottomNavigationBar(
        items: List<BottomNavItem>,
        navController: NavHostController
    ) {
        NavigationBar {
            val currentRoute =
                navController.currentBackStackEntryAsState().value?.destination?.route
            items.forEach { item ->
                NavigationBarItem(
                    selected = currentRoute == item.route,
                    onClick = { navController.navigate(item.route) },
                    icon = { Icon(item.icon, contentDescription = item.name) },
                    label = { Text(item.name) }
                )
            }
        }
    }
}