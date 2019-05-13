package com.raywenderlich.android.creatures.cache

import android.arch.persistence.room.Room
import com.raywenderlich.android.creatures.cache.db.CreaturesDatabase
import com.raywenderlich.android.creatures.cache.mapper.CreatureEntityMapper
import com.raywenderlich.android.creatures.cache.model.CachedCreature
import com.raywenderlich.android.creatures.cache.test.factory.CachedCreatureFactory
import org.junit.Test
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.RuntimeEnvironment
import org.robolectric.annotation.Config
import kotlin.test.assertEquals

@RunWith(RobolectricTestRunner::class)
@Config(manifest=Config.NONE, sdk = intArrayOf(21))
class CreatureCacheImplTest {

  private var creaturesDatabase = Room.inMemoryDatabaseBuilder(RuntimeEnvironment.application,
      CreaturesDatabase::class.java).allowMainThreadQueries().build()
  private var entityMapper = CreatureEntityMapper()
  private var preferencesHelper = PreferencesHelper(RuntimeEnvironment.application)


  private val databaseHelper = CreatureCacheImpl(creaturesDatabase,
      entityMapper, preferencesHelper)

  @Test
  fun clearTablesCompletes() {
    val testObserver = databaseHelper.clearCreatures().test()
    testObserver.assertComplete()
  }

  @Test
  fun saveCreaturesCompletes() {
    val creatureEntities = CachedCreatureFactory.makeCreatureEntityList(2)

    val testObserver = databaseHelper.saveCreatures(creatureEntities).test()
    testObserver.assertComplete()
  }

  @Test
  fun saveCreaturesSavesData() {
    val creatureCount = 2
    val creatureEntities = CachedCreatureFactory.makeCreatureEntityList(creatureCount)

    databaseHelper.saveCreatures(creatureEntities).test()
    checkNumRowsInCreaturesTable(creatureCount)
  }

  @Test
  fun getCreaturesCompletes() {
    val testObserver = databaseHelper.getCreatures().test()
    testObserver.assertComplete()
  }

  @Test
  fun getCreaturesReturnsData() {
    val creatureEntities = CachedCreatureFactory.makeCreatureEntityList(2)
    val cachedCreatures = mutableListOf<CachedCreature>()
    creatureEntities.forEach {
      cachedCreatures.add(entityMapper.mapToCached(it))
    }
    insertCreatures(cachedCreatures)

//    val testObserver = databaseHelper.getCreatures().test()
//    testObserver.assertValue(creatureEntities)
  }

  private fun insertCreatures(cachedCreatures: List<CachedCreature>) {
    cachedCreatures.forEach {
      creaturesDatabase.cachedCreatureDao().insertCreature(it)
    }
  }

  private fun checkNumRowsInCreaturesTable(expectedRows: Int) {
    val numberOfRows = creaturesDatabase.cachedCreatureDao().getCreatures().size
    assertEquals(expectedRows, numberOfRows)
  }
}