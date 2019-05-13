package com.raywenderlich.android.creatures.data.repository

import com.raywenderlich.android.creatures.data.model.CreatureEntity
import io.reactivex.Completable
import io.reactivex.Flowable
import io.reactivex.Single


/**
 * Interface defining methods for the data operations related to Creatures.
 * This is to be implemented by external data source layers, setting the requirements for the
 * operations that need to be implemented
 */
interface CreatureDataStore {
  fun clearCreatures(): Completable
  fun saveCreatures(creatures: List<CreatureEntity>): Completable
  fun getCreatures(): Flowable<List<CreatureEntity>>
  fun isCached(): Single<Boolean>
}