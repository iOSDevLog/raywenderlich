package com.raywenderlich.android.creatures.cache.dao

import android.arch.persistence.room.Room
import com.raywenderlich.android.creatures.cache.db.CreaturesDatabase
import com.raywenderlich.android.creatures.cache.test.factory.CachedCreatureFactory
import org.junit.After
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.RuntimeEnvironment
import org.robolectric.annotation.Config

@Config(manifest=Config.NONE)
@RunWith(RobolectricTestRunner::class)
open class CachedCreatureDaoTest {

  private lateinit var creaturesDatabase: CreaturesDatabase

  @Before
  fun initDb() {
    creaturesDatabase = Room.inMemoryDatabaseBuilder(
        RuntimeEnvironment.application.baseContext,
        CreaturesDatabase::class.java)
        .allowMainThreadQueries()
        .build()
  }

  @After
  fun closeDb() {
    creaturesDatabase.close()
  }

  @Test
  fun insertCreaturesSavesData() {
    val cachedCreature = CachedCreatureFactory.makeCachedCreature()
    creaturesDatabase.cachedCreatureDao().insertCreature(cachedCreature)

    val creatures = creaturesDatabase.cachedCreatureDao().getCreatures()
    assert(creatures.isNotEmpty())
  }

  @Test
  fun getCreaturesRetrievesData() {
    val cachedCreatures = CachedCreatureFactory.makeCachedCreatureList(5)

    cachedCreatures.forEach {
      creaturesDatabase.cachedCreatureDao().insertCreature(it) }

    val retrievedCreatures = creaturesDatabase.cachedCreatureDao().getCreatures()
    assert(retrievedCreatures == cachedCreatures.sortedWith(compareBy({ it.id }, { it.id })))
  }
}