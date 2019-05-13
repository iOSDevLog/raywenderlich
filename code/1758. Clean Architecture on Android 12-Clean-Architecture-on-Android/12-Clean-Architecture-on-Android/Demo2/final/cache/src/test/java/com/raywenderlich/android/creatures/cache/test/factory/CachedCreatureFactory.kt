package com.raywenderlich.android.creatures.cache.test.factory

import com.raywenderlich.android.creatures.cache.model.CachedCreature
import com.raywenderlich.android.creatures.cache.test.factory.DataFactory.Factory.randomLong
import com.raywenderlich.android.creatures.cache.test.factory.DataFactory.Factory.randomUuid
import com.raywenderlich.android.creatures.data.model.CreatureEntity


/**
 * Factory class for Creature related instances
 */
class CachedCreatureFactory {

  companion object Factory {

    fun makeCachedCreature(): CachedCreature {
      return CachedCreature(randomLong(), randomUuid(), randomUuid(), randomUuid(), randomUuid(), randomUuid())
    }

    fun makeCreatureEntity(): CreatureEntity {
      return CreatureEntity(randomLong(), randomUuid(), randomUuid(), randomUuid(), randomUuid(), randomUuid())
    }

    fun makeCreatureEntityList(count: Int): List<CreatureEntity> {
      val creatureEntities = mutableListOf<CreatureEntity>()
      repeat(count) {
        creatureEntities.add(makeCreatureEntity())
      }
      return creatureEntities
    }

    fun makeCachedCreatureList(count: Int): List<CachedCreature> {
      val cachedCreatures = mutableListOf<CachedCreature>()
      repeat(count) {
        cachedCreatures.add(makeCachedCreature())
      }
      return cachedCreatures
    }
  }
}