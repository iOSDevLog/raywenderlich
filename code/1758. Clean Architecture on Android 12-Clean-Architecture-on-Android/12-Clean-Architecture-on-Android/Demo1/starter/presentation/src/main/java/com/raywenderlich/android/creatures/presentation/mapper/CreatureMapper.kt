package com.raywenderlich.android.creatures.presentation.mapper

import com.raywenderlich.android.creatures.domain.model.Creature
import com.raywenderlich.android.creatures.presentation.model.CreatureView
import javax.inject.Inject


/**
 * Map a [CreatureView] to and from a [Creature] instance when data is moving between
 * this layer and the Domain layer
 */
open class CreatureMapper @Inject constructor(): Mapper<CreatureView, Creature> {
  override fun mapToView(type: Creature) =
    CreatureView(type.firstName, type.lastName, type.nickname, type.image, type.planet)
}