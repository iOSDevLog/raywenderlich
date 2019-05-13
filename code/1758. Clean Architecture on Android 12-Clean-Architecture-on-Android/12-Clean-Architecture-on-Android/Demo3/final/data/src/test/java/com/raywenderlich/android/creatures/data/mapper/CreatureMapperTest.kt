package com.raywenderlich.android.creatures.data.mapper

import com.raywenderlich.android.creatures.data.model.CreatureEntity
import com.raywenderlich.android.creatures.data.test.factory.CreatureEntityFactory
import com.raywenderlich.android.creatures.domain.model.Creature
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4
import kotlin.test.assertEquals


@RunWith(JUnit4::class)
class CreatureMapperTest {

  private lateinit var creatureMapper: CreatureMapper

  @Before
  fun setUp() {
    creatureMapper = CreatureMapper()
  }

  @Test
  fun mapFromEntityMapsData() {
    val creatureEntity = CreatureEntityFactory.makeCreatureEntity()
    val creature = creatureMapper.mapFromEntity(creatureEntity)

    assertCreatureDataEquality(creatureEntity, creature)
  }

  @Test
  fun mapToEntityMapsData() {
    val cachedCreature = CreatureEntityFactory.makeCreature()
    val creatureEntity = creatureMapper.mapToEntity(cachedCreature)

    assertCreatureDataEquality(creatureEntity, cachedCreature)
  }

  private fun assertCreatureDataEquality(creatureEntity: CreatureEntity,
                                         creature: Creature) {
    assertEquals(creatureEntity.firstName, creature.firstName)
    assertEquals(creatureEntity.lastName, creature.lastName)
    assertEquals(creatureEntity.nickname, creature.nickname)
    assertEquals(creatureEntity.image, creature.image)
    assertEquals(creatureEntity.planet, creature.planet)
  }
}