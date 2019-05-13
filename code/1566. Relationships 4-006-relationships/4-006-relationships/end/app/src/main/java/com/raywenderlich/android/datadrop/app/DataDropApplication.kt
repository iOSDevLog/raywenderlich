/*
 * Copyright (c) 2018 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

package com.raywenderlich.android.datadrop.app

import android.app.Application
import android.arch.persistence.db.SupportSQLiteDatabase
import android.arch.persistence.room.Room
import android.arch.persistence.room.RoomDatabase
import android.content.Context
import android.os.AsyncTask
import com.google.android.gms.maps.model.LatLng
import com.raywenderlich.android.datadrop.model.*


class DataDropApplication : Application() {

  companion object {
    lateinit var database: DropDatabase

    private lateinit var instance: DataDropApplication

    fun getAppContext(): Context = instance.applicationContext
  }

  override fun onCreate() {
    instance = this
    super.onCreate()

    database = Room.databaseBuilder(this, DropDatabase::class.java, "drop_database")
        .addCallback(roomDatabaseCallback).build()
  }

  private val roomDatabaseCallback = object : RoomDatabase.Callback() {
    override fun onOpen(db: SupportSQLiteDatabase) {
      super.onOpen(db)
      PopulateDbAsync(DataDropApplication.database).execute()
    }
  }

  private class PopulateDbAsync(db: DropDatabase) : AsyncTask<Void, Void, Void>() {
    private val markerColorDao: MarkerColorDao = db.markerColorDao()
    private val dropDao: DropDao = db.dropDao()

    override fun doInBackground(vararg params: Void): Void? {
      var markerColor = MarkerColor(MarkerColor.RED_COLOR)
      markerColorDao.insert(markerColor)
      markerColor = MarkerColor(MarkerColor.GREEN_COLOR)
      markerColorDao.insert(markerColor)
      markerColor = MarkerColor(MarkerColor.BLUE_COLOR)
      markerColorDao.insert(markerColor)

      val drop = Drop(LatLng(37.4220, -122.0841), "42")
      dropDao.insert(drop)

      return null
    }
  }

}