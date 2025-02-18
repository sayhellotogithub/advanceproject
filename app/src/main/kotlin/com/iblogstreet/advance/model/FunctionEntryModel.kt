package com.iblogstreet.advance.model

import androidx.compose.ui.graphics.vector.ImageVector

/**
 * @author junwang
 * @date 2024/07/25 0:04
 */
class FunctionEntryModel(
    val entryType: EntryType,
    val title: String? = null
)

enum class EntryType {
    LOGIN,
    PHOTO
}

data class BottomMenuItem(
    val title: String,
    val defaultIcon: ImageVector,
    val selectedIcon: ImageVector,
    val route:String
)
