package  com.softlink.wafi.src.navigation.main

import android.annotation.SuppressLint
import android.util.Log
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.outlined.Home
import androidx.compose.material.icons.outlined.Menu
import androidx.compose.material.icons.outlined.Person
import androidx.compose.material3.Icon
import androidx.compose.material3.NavigationBar
import androidx.compose.material3.NavigationBarItem
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.setValue


@SuppressLint("UnrememberedMutableState")
@Composable()
fun Nav(){

    var selectedIndex: Int by mutableIntStateOf(value = 2)


    NavigationBar {


        NavigationBarItem(
            selected =  selectedIndex == 1,
            onClick = { /*TODO*/ },
            icon = {
                Icon(imageVector =  Icons.Outlined.Menu, contentDescription = null)
            }
        )



        NavigationBarItem(
            selected = selectedIndex == 2,
            onClick = { /*TODO*/ },
            icon = {
                Icon(imageVector =  Icons.Outlined.Home, contentDescription = null)
            }
        )

        NavigationBarItem(
            selected =  selectedIndex == 3,
            onClick = { /*TODO*/ },
            icon = {
                Icon(imageVector =  Icons.Outlined.Person, contentDescription = null)
            }
        )

    }
}