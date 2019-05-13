package com.raywenderlich.android.creatures.domain.test.factory

import com.raywenderlich.android.creatures.domain.model.Creature
import com.raywenderlich.android.creatures.domain.test.factory.DataFactory.Factory.randomLong
import com.raywenderlich.android.creatures.domain.test.factory.DataFactory.Factory.randomUuid


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

    private fun makeCreature() = Creature(randomLong(), randomUuid(), randomUuid(), randomUuid(), randomUuid(), randomUuid())

    // TODO
//    fun makeJupiterCreatureList(count: Int): List<Creature> {
//      val creatures = mutableListOf<Creature>()
//      repeat(count) {
//        creatures.add(makeJupiterCreature())
//      }
//      return creatures
//    }
//
//    private fun makeJupiterCreature() = Creature(randomLong(),
//        randomUuid(),
//        randomUuid(),
//        randomUuid(),
//        randomUuid(),
//        "Jupiter")
  }
}