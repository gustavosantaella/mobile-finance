package com.softlink.wafi.src.database

import android.content.ContentValues
import android.content.Context
import android.database.sqlite.SQLiteOpenHelper
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteDatabase.CursorFactory
import java.sql.Date

class SQLiteDB(context: Context, name: String, factory: CursorFactory?, version: Int) : SQLiteOpenHelper(context, name, factory, version)  {

    class Dbs{
        object Names {
            const val MAIN: String = "WAFI"
        }
    }
    override fun onCreate(db: SQLiteDatabase) {
        db.execSQL("CREATE TABLE IF NOT EXISTS wallets(id BIGINT PRIMARY KEY AUTOINCREMENT, name VARCHAR(255) UNIQUE NOT NULL , balance FLOAT NOT NULL DEFAULT 0, created_at text DEFAULT NULL)");
        db.execSQL("CREATE TABLE IF NOT EXISTS movements(id BIGINT PRIMARY KEY AUTOINCREMENT, walled_id BIGINT NOT NULL, amount FLOAT NOT NULL, description VARCHAR(255) DEFAULT NULL, created_at text DEFAULT NULL)");

    }

    override fun onUpgrade(db: SQLiteDatabase, oldVersion: Int, newVersion: Int) {

    }
}