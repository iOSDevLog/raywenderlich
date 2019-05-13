package com.raywenderlich.android.creatures.data.source

import com.raywenderlich.android.creatures.data.repository.CreatureCache
import com.raywenderlich.android.creatures.data.repository.CreatureDataStore
import javax.inject.Inject


/**
 * Create an instance of a CreatureDataStore
 */
open class CreatureDataStoreFactory @Inject constructor(
    private val creatureCache: CreatureCache,
    private val creatureCacheDataStore: CreatureCacheDataStore,
    private val creatureRemoteDataStore: CreatureRemoteDataStore) {

  /**
   * Returns a DataStore based on whether or not there is content in the cache and the cache
   * has not expired
   */
  open fun retrieveDataStore(isCached: Boolean): CreatureDataStore {
    if (isCached && !creatureCache.isExpired()) {
      return retrieveCacheDataStore()
    }
    return retrieveRemoteDataStore()
  }

  /**
   * Return an instance of the Cache Data Store
   */
  open fun retrieveCacheDataStore(): CreatureDataStore {
    return creatureCacheDataStore
  }

  /**
   * Return an instance of the Remote Data Store
   */
  open fun retrieveRemoteDataStore(): CreatureDataStore {
    return creatureRemoteDataStore
  }

}