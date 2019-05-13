package com.raywenderlich.android.creatures.remote

import com.raywenderlich.android.creatures.data.model.CreatureEntity
import com.raywenderlich.android.creatures.data.repository.CreatureRemote
import com.raywenderlich.android.creatures.remote.mapper.CreatureEntityMapper
import io.reactivex.Flowable
import javax.inject.Inject


/**
 * Remote implementation for retrieving Creature instances. This class implements the
 * [CreatureRemote] from the Data layer as it is that layers responsibility for defining the
 * operations in which data store implementation layers can carry out.
 */
class CreatureRemoteImpl @Inject constructor(private val creatureService: CreatureService,
                                             private val entityMapper: CreatureEntityMapper):
    CreatureRemote {

  /**
   * Retrieve a list of [CreatureEntity] instances from the [CreatureService].
   */
  override fun getCreatures(): Flowable<List<CreatureEntity>> {
    return creatureService.getCreatures()
        .map { it.creatures }
        .map {
          val entities = mutableListOf<CreatureEntity>()
          it.forEach { entities.add(entityMapper.mapFromRemote(it)) }
          entities
        }
  }

}