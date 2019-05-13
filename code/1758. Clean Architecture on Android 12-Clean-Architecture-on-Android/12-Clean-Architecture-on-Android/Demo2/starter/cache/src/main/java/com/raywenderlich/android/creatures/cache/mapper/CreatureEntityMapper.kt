package com.raywenderlich.android.creatures.cache.mapper

import com.raywenderlich.android.creatures.cache.model.CachedCreature
import com.raywenderlich.android.creatures.data.model.CreatureEntity
import javax.inject.Inject


/**
 * Map a [CachedCreature] instance to and from a [CreatureEntity] instance when data is moving between
 * this layer and the Data layer
 */
open class CreatureEntityMapper @Inject constructor(): EntityMapper<CachedCreature, CreatureEntity> {

  override fun mapToCached(type: CreatureEntity) =
    CachedCreature(type.id, type.firstName, type.lastName, type.nickname, type.image, type.planet)

  override fun mapFromCached(type: CachedCreature) =
    CreatureEntity(type.id, type.firstName, type.lastName, type.nickname, type.image, type.planet)
}