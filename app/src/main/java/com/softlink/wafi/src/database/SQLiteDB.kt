package com.softlink.wafi.src.database

import android.content.Context
import android.database.sqlite.SQLiteOpenHelper
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteDatabase.CursorFactory
class SQLiteDB(context: Context, name: String, factory: CursorFactory?, version: Int) : SQLiteOpenHelper(context, name, factory, version)  {

    class Dbs{
        object Names {
            const val MAIN: String = "WAFI"
        }
    }
    override fun onCreate(db: SQLiteDatabase) {
        db.execSQL("CREATE TABLE IF NOT EXISTS wallets(id SERIAL PRIMARY KEY, name VARCHAR(255) UNIQUE NOT NULL , balance FLOAT NOT NULL DEFAULT 0) ");
        db.execSQL("CREATE TABLE IF NOT EXISTS movements(id SERIAL PRIMARY KEY, walled_id BIGINT NOT NULL, amount FLOAT NOT NULL, description VARCHAR(255) DEFAULT NULL)");
    }

    override fun onUpgrade(db: SQLiteDatabase, oldVersion: Int, newVersion: Int) {

    }
}