package com.raywenderlich.android.creatures.presentation.test.factory

import com.raywenderlich.android.creatures.domain.model.Creature
import com.raywenderlich.android.creatures.presentation.model.CreatureView
import com.raywenderlich.android.creatures.presentation.test.factory.DataFactory.Factory.randomLong
import com.raywenderlich.android.creatures.presentation.test.factory.DataFactory.Factory.randomUuid


/**
 * Factory class for Creature related instances
 */
class CreatureFactory {

  companion object Factory {

    fun makeCreatureList(count: Int): List<Creature> {
      val creatures = mutableListOf<Creature>()
      repeat(count) {
        creatures.add(makeCreature())
      }
      return creatures
    }

    private fun makeCreature(): Creature {
      return Creature(randomLong(), randomUuid(), randomUuid(), randomUuid(), randomUuid(), randomUuid())
    }

    fun makeCreatureViewList(count: Int): List<CreatureView> {
      val creatures = mutableListOf<CreatureView>()
      repeat(count) {
        creatures.add(makeCreatureView())
      }
      return creatures
    }

    private fun makeCreatureView(): CreatureView {
      return CreatureView(randomUuid(), randomUuid(), randomUuid(), randomUuid(), randomUuid())
    }

    fun makeJupiterCreatureList(count: Int): List<Creature> {
      val creatures = mutableListOf<Creature>()
      repeat(count) {
        creatures.add(makeJupiterCreature())
      }
      return creatures
    }

    private fun makeJupiterCreature(): Creature =
        Creature(randomLong(), randomUuid(), randomUuid(), randomUuid(), randomUuid(), "Jupiter")

    fun makeJupiterCreatureViewList(count: Int): List<CreatureView> {
      val creatures = mutableListOf<CreatureView>()
      repeat(count) {
        creatures.add(makeJupiterCreatureView())
      }
      return creatures
    }

    private fun makeJupiterCreatureView(): CreatureView =
        CreatureView(randomUuid(), randomUuid(), randomUuid(), randomUuid(), "Jupiter")

  }
}