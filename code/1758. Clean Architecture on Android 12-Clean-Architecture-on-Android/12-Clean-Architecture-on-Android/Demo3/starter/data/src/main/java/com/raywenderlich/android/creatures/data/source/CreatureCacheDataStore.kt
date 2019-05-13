package com.raywenderlich.android.creatures.data.source

import com.raywenderlich.android.creatures.data.model.CreatureEntity
import com.raywenderlich.android.creatures.data.repository.CreatureCache
import com.raywenderlich.android.creatures.data.repository.CreatureDataStore
import io.reactivex.Completable
import io.reactivex.Flowable
import io.reactivex.Single
import javax.inject.Inject


/**
 * Implementation of the [CreatureDataStore] interface to provide a means of communicating
 * with the local data source
 */
open class CreatureCacheDataStore @Inject constructor(private val creatureCache: CreatureCache) :
    CreatureDataStore {

  override fun clearCreatures(): Completable {
    return creatureCache.clearCreatures()
  }

  override fun saveCreatures(creatures: List<CreatureEntity>): Completable {
    return creatureCache.saveCreatures(creatures)
        .doOnComplete {
          creatureCache.setLastCacheTime(System.currentTimeMillis())
        }
  }

  override fun getCreatures(): Flowable<List<CreatureEntity>> {
    return creatureCache.getCreatures()
  }

  override fun isCached(): Single<Boolean> {
    return creatureCache.isCached()
  }
}