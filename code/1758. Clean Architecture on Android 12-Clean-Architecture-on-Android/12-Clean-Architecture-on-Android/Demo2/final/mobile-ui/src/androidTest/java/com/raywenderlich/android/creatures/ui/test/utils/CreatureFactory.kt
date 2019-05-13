package com.raywenderlich.android.creatures.ui.test.utils

import com.raywenderlich.android.creatures.domain.model.Creature
import com.raywenderlich.android.creatures.presentation.model.CreatureView
import com.raywenderlich.android.creatures.ui.test.utils.DataFactory.randomLong
import com.raywenderlich.android.creatures.ui.test.utils.DataFactory.randomUuid


/**
 * Factory class for Creature related instances
 */
object CreatureFactory {

  fun makeCreatureView(): CreatureView {
    return CreatureView(randomUuid(), randomUuid(), randomUuid(), randomUuid(), randomUuid())
  }

  fun makeCreatureList(count: Int): List<Creature> {
    val creatures = mutableListOf<Creature>()
    repeat(count) {
      creatures.add(CreatureFactory.makeCreatureModel())
    }
    return creatures
  }

  fun makeCreatureModel(): Creature {
    return Creature(randomLong(), randomUuid(), randomUuid(), randomUuid(), randomUuid(), randomUuid())
  }
}