package com.raywenderlich.android.creatures.ui.test.factory

import com.raywenderlich.android.creatures.presentation.model.CreatureView
import com.raywenderlich.android.creatures.ui.test.factory.DataFactory.randomUuid


/**
 * Factory class for Creature related instances
 */
object CreatureFactory {
  fun makeCreatureView(): CreatureView {
    return CreatureView(randomUuid(), randomUuid(), randomUuid(), randomUuid(), randomUuid())
  }
}