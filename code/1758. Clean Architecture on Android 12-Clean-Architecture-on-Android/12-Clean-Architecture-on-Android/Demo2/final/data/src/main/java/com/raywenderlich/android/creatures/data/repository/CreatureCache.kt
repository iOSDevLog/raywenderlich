package com.raywenderlich.android.creatures.data.repository

import com.raywenderlich.android.creatures.data.model.CreatureEntity
import io.reactivex.Completable
import io.reactivex.Flowable
import io.reactivex.Single

/**
 * Interface defining methods for the caching of Creatures. This is to be implemented by the
 * cache layer, using this interface as a way of communicating.
 */
interface CreatureCache {
  /**
   * Clear all Creatures from the cache.
   */
  fun clearCreatures(): Completable

  /**
   * Save a given list of Creatures to the cache.
   */
  fun saveCreatures(creatures: List<CreatureEntity>): Completable

  /**
   * Retrieve a list of Creatures from the cache.
   */
  fun getCreatures(): Flowable<List<CreatureEntity>>

  /**
   * Check whether there is a list of Creatures stored in the cache.
   *
   * @return true if the list is cached, otherwise false
   */
  fun isCached(): Single<Boolean>

  /**
   * Set a point in time at when the cache was last updated.
   *
   * @param lastCache the point in time at when the cache was last updated
   */
  fun setLastCacheTime(lastCache: Long)

  /**
   * Check if the cache is expired.
   *
   * @return true if the cache is expired, otherwise false
   */
  fun isExpired(): Boolean
}