package com.raywenderlich.android.creatures.remote.mapper

import com.raywenderlich.android.creatures.data.model.CreatureEntity
import com.raywenderlich.android.creatures.remote.model.CreatureModel
import javax.inject.Inject


/**
 * Map a [CreatureModel] to a [CreatureEntity] instance when data is moving between
 * this layer and the Data layer
 */
open class CreatureEntityMapper @Inject constructor(): EntityMapper<CreatureModel, CreatureEntity> {

  override fun mapFromRemote(type: CreatureModel) =
    CreatureEntity(type.id, type.firstName, type.lastName, type.nickname, type.image, type.planet)
}