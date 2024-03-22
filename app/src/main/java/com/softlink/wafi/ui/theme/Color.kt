package com.softlink.wafi.ui.theme

import androidx.compose.material3.ColorScheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color

private  val mainHexBlueColor = "#2489e7"
val Purple80 = Color(0xFFD0BCFF)
val PurpleGrey80 = Color(0xFFCCC2DC)
val Pink80 = Color(0xFFEFB8C8)

val Purple40 = Color(0xFF6650a4)
val PurpleGrey40 = Color(0xFF625b71)
val Pink40 = Color(0xFF7D5260)
val Blank = Color(0xFFFFFFFF)
val MainBlueColor = Color(android.graphics.Color.parseColor(mainHexBlueColor))

fun mainBlueColorArgb(): Int {
    val color = android.graphics.Color.parseColor(mainHexBlueColor)
    val alpha = android.graphics.Color.alpha(color)
    val red = android.graphics.Color.red(color)
    val green = android.graphics.Color.green(color)
    val blue = android.graphics.Color.blue(color)
    return (alpha shl 24) or (red shl 16) or (green shl 8) or blue
}

@Composable()
fun default(): Color {

    return  MaterialTheme.colorScheme.background;
}