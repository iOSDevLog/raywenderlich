package com.raywenderlich.android.creatures.cache

import com.raywenderlich.android.creatures.cache.db.CreaturesDatabase
import com.raywenderlich.android.creatures.cache.mapper.CreatureEntityMapper
import com.raywenderlich.android.creatures.data.model.CreatureEntity
import com.raywenderlich.android.creatures.data.repository.CreatureCache
import io.reactivex.Completable
import io.reactivex.Flowable
import io.reactivex.Single
import javax.inject.Inject


/**
 * Cached implementation for retrieving and saving Creature instances. This class implements the
 * [CreatureCache] from the Data layer as it is that layers responsibility for defining the
 * operations in which data store implementation layers can carry out.
 */
class CreatureCacheImpl @Inject constructor(private val creaturesDatabase: CreaturesDatabase,
                                            private val entityMapper: CreatureEntityMapper,
                                            private val preferencesHelper: PreferencesHelper) :
    CreatureCache {

  companion object {
    private const val EXPIRATION_TIME = (60 * 10 * 1000).toLong() // 10 minutes
  }

  /**
   * Retrieve an instance from the database, used for tests.
   */
  internal fun getDatabase(): CreaturesDatabase {
    return creaturesDatabase
  }

  /**
   * Remove all the data from all the tables in the database.
   */
  override fun clearCreatures(): Completable {
    return Completable.defer {
      creaturesDatabase.cachedCreatureDao().clearCreatures()
      Completable.complete()
    }
  }

  /**
   * Save the given list of [CreatureEntity] instances to the database.
   */
  override fun saveCreatures(creatures: List<CreatureEntity>): Completable {
    return Completable.defer {
      creatures.forEach {
        creaturesDatabase.cachedCreatureDao().insertCreature(entityMapper.mapToCached(it))
      }
      Completable.complete()
    }
  }

  /**
   * Retrieve a list of [CreatureEntity] instances from the database.
   */
  override fun getCreatures(): Flowable<List<CreatureEntity>> {
    return Flowable.defer {
      Flowable.just(creaturesDatabase.cachedCreatureDao().getCreatures())
    }.map {
      it.map { entityMapper.mapFromCached(it) }
    }
  }

  /**
   * Check whether there are instances of [CachedCreature] stored in the cache.
   */
  override fun isCached(): Single<Boolean> {
    return Single.defer {
      Single.just(creaturesDatabase.cachedCreatureDao().getCreatures().isNotEmpty())
    }
  }

  /**
   * Set a point in time at when the cache was last updated.
   */
  override fun setLastCacheTime(lastCache: Long) {
    preferencesHelper.lastCacheTime = lastCache
  }

  /**
   * Check whether the current cached data exceeds the defined [EXPIRATION_TIME] time.
   */
  override fun isExpired(): Boolean {
    val currentTime = System.currentTimeMillis()
    val lastUpdateTime = this.getLastCacheUpdateTimeMillis()
    return currentTime - lastUpdateTime > EXPIRATION_TIME
  }

  /**
   * Get in millis, the last time the cache was accessed.
   */
  private fun getLastCacheUpdateTimeMillis(): Long {
    return preferencesHelper.lastCacheTime
  }
}