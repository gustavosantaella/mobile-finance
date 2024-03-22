package com.softlink.wafi

import android.content.Intent
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.Surface
import androidx.compose.ui.Modifier
import com.softlink.wafi.src.activities.home.HomeActivity
import com.softlink.wafi.src.splash.MainSplash
import com.softlink.wafi.ui.theme.WafiTheme
import com.softlink.wafi.ui.theme.default
import java.util.concurrent.TimeUnit

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {

            WafiTheme {
                // A surface container using the 'background' color from the theme
                Surface(modifier = Modifier.fillMaxSize(), color = default()) {
                    MainSplash()
                    TimeUnit.SECONDS.sleep(10L)

                }
            }
        }
    }
}
