package com.lnd.handybuddy.ui.navigation

import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import com.lnd.handybuddy.view.ChatScreen
import com.lnd.handybuddy.view.HistoryScreen
import com.lnd.handybuddy.view.ProfileScreen
import com.lnd.handybuddy.view.SavedScreen
import com.lnd.handybuddy.view.SearchScreen

sealed class Screen(val route: String) {
    data object Chat : Screen("chat")
    data object Profile : Screen("profile")
    data object Saved : Screen("saved")
    data object Search : Screen("search")
    data object History: Screen("history")
}

@Composable
fun NavigationGraph(navController: NavHostController) {
    NavHost(navController, startDestination = Screen.Search.route) {
        composable(Screen.Search.route) { SearchScreen() }
        composable(Screen.Chat.route) { ChatScreen() }
        composable(Screen.Profile.route) { ProfileScreen() }
        composable(Screen.Saved.route) { SavedScreen() }
        composable(Screen.History.route) { HistoryScreen() }
    }
}