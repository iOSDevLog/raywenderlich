package com.raywenderlich.android.creatures.data

import com.raywenderlich.android.creatures.data.mapper.CreatureMapper
import com.raywenderlich.android.creatures.data.model.CreatureEntity
import com.raywenderlich.android.creatures.data.source.CreatureDataStoreFactory
import com.raywenderlich.android.creatures.domain.model.Creature
import com.raywenderlich.android.creatures.domain.repository.CreatureRepository
import io.reactivex.Completable
import io.reactivex.Flowable
import javax.inject.Inject


/**
 * Provides an implementation of the [CreatureRepository] interface for communicating to and from
 * data sources
 */
class CreatureDataRepository @Inject constructor(private val factory: CreatureDataStoreFactory,
                                                 private val creatureMapper: CreatureMapper) : CreatureRepository {

  override fun clearCreatures(): Completable {
    return factory.retrieveCacheDataStore().clearCreatures()
  }

  override fun saveCreatures(creatures: List<Creature>): Completable {
    val creatureEntities = mutableListOf<CreatureEntity>()
    creatures.map { creatureEntities.add(creatureMapper.mapToEntity(it)) }
    return factory.retrieveCacheDataStore().saveCreatures(creatureEntities)
  }

  override fun getCreatures(): Flowable<List<Creature>> {
    return factory.retrieveCacheDataStore().isCached()
        .flatMapPublisher {
          factory.retrieveDataStore(it).getCreatures()
        }
        .flatMap {
          Flowable.just(it.map { creatureMapper.mapFromEntity(it) })
        }
        .flatMap {
          saveCreatures(it).toSingle { it }.toFlowable()
        }
  }

  override fun getJupiterCreatures(): Flowable<List<Creature>> =
      getCreatures().flatMap { Flowable.just(it.filter { it.planet == "Jupiter" }) }
}