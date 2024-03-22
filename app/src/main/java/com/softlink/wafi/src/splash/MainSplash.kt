package com.softlink.wafi.src.splash

import RenderMainLogo
import android.annotation.SuppressLint
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.TextUnit
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.softlink.wafi.ui.theme.Blank
import com.softlink.wafi.ui.theme.MainBlueColor
import com.softlink.wafi.ui.theme.WafiTheme


@SuppressLint("CustomSplashScreen")
class MainSplashActivity : ComponentActivity(){

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent(){
            WafiTheme(
                mainBlueColor = true
            ) {
                Surface(modifier = Modifier.fillMaxSize(), color = MainBlueColor) {
                    MainSplash()
                }
        }


    }
}
@Composable()
private fun MainSplash()  {


                Column(
                        modifier = Modifier.fillMaxSize(),
                    verticalArrangement = Arrangement.Center,
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    Box(contentAlignment = Alignment.Center, modifier = Modifier.padding(20.dp) ){
                        RenderMainLogo()

                    }
                    Text(text = "MANAGE YOUR FINANCES WITH ME", color = Blank, fontSize = 30.sp, textAlign = TextAlign.Center, letterSpacing = 10.sp, lineHeight = 50.sp)

                }
    }
}


