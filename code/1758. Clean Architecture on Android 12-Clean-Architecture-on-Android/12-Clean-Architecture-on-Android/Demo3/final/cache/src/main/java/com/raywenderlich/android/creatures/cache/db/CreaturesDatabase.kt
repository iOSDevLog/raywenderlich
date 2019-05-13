package com.raywenderlich.android.creatures.cache.db

import android.arch.persistence.room.Database
import android.arch.persistence.room.Room
import android.arch.persistence.room.RoomDatabase
import android.content.Context
import com.raywenderlich.android.creatures.cache.dao.CachedCreatureDao
import com.raywenderlich.android.creatures.cache.model.CachedCreature
import javax.inject.Inject


@Database(entities = arrayOf(CachedCreature::class), version = 1)
abstract class CreaturesDatabase @Inject constructor() : RoomDatabase() {

  abstract fun cachedCreatureDao(): CachedCreatureDao

  private var instance: CreaturesDatabase? = null

  private val lock = Any()

  fun getInstance(context: Context): CreaturesDatabase {
    if (instance == null) {
      synchronized(lock) {
        if (instance == null) {
          instance = Room.databaseBuilder(context.applicationContext,
              CreaturesDatabase::class.java, "creatures.db").build()
        }
        return instance!!
      }
    }
    return instance!!
  }
}