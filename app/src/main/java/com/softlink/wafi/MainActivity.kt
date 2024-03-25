package com.softlink.wafi

import android.content.Intent
import android.os.Bundle
import android.os.Handler
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.Surface
import androidx.compose.ui.Modifier
import com.softlink.wafi.src.activities.home.HomeActivity
import com.softlink.wafi.src.helpers.Redirect
import com.softlink.wafi.src.splash.MainSplashActivity
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
                    val intent = Intent(this, MainSplashActivity::class.java)
                    startActivity(intent)


                    Handler().postDelayed({
                                          Redirect.To(this, HomeActivity::class.java, null)
                    }, 5000)


                }
            }
        }
    }
}
