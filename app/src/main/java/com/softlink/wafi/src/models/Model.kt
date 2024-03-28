package com.softlink.wafi.src.models

import android.content.Context
import com.softlink.wafi.src.database.SQLiteDB
import android.database.sqlite.SQLiteDatabase
abstract class Model(val table: String) {

    protected fun getConnection(context: Context): SQLiteDatabase {
        val conn = SQLiteDB(context, SQLiteDB.Dbs.Names.MAIN, null, 1);
        return conn.writableDatabase
    }

    protected fun all(context: Context){
        val conn = getConnection(context);
//        val cursor = conn.query(false,  this.table , null, null, null, null, null, null, null, null)
//        val  columnNames = cursor.columnNames;
//        cursor.
//        cursor.close();

    }

}

