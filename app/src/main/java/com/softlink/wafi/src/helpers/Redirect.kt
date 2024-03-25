package com.softlink.wafi.src.helpers

import android.app.Activity
import android.content.Intent


class Redirect{
    class To(parent: Activity, activity: Class<*>, data: Class<*>?){

        init {
            val intent: Intent = Intent(parent, activity)

            when {
                data != null -> intent.putExtra("data",  data)
            }

            parent.startActivity(intent)
        }

    }
}