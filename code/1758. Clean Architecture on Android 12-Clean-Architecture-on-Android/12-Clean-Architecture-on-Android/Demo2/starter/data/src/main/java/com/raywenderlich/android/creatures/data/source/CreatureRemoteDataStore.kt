package com.raywenderlich.android.creatures.data.source

import com.raywenderlich.android.creatures.data.model.CreatureEntity
import com.raywenderlich.android.creatures.data.repository.CreatureDataStore
import com.raywenderlich.android.creatures.data.repository.CreatureRemote
import io.reactivex.Completable
import io.reactivex.Flowable
import io.reactivex.Single
import javax.inject.Inject


/**
 * Implementation of the [CreatureDataStore] interface to provide a means of communicating
 * with the remote data source
 */
open class CreatureRemoteDataStore @Inject constructor(private val creatureRemote: CreatureRemote) :
    CreatureDataStore {

  override fun clearCreatures(): Completable {
    throw UnsupportedOperationException()
  }

  override fun saveCreatures(creatures: List<CreatureEntity>): Completable {
    throw UnsupportedOperationException()
  }

  override fun getCreatures(): Flowable<List<CreatureEntity>> {
    return creatureRemote.getCreatures()
  }

  override fun isCached(): Single<Boolean> {
    throw UnsupportedOperationException()
  }
}