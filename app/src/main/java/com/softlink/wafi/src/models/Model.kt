package com.softlink.wafi.src.models

import android.content.Context
import com.softlink.wafi.src.database.SQLiteDB
import android.database.sqlite.SQLiteDatabase
abstract class Model {

    protected fun getConnection(context: Context): SQLiteDatabase {
        val conn = SQLiteDB(context, SQLiteDB.Dbs.Names.MAIN, null, 1);
        return conn.writableDatabase
    }

}