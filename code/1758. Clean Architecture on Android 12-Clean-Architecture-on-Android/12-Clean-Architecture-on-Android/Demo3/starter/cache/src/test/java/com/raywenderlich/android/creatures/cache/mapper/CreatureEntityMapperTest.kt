package com.raywenderlich.android.creatures.cache.mapper

import com.raywenderlich.android.creatures.cache.model.CachedCreature
import com.raywenderlich.android.creatures.cache.test.factory.CachedCreatureFactory
import com.raywenderlich.android.creatures.data.model.CreatureEntity
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4
import kotlin.test.assertEquals

@RunWith(JUnit4::class)
class CreatureEntityMapperTest {

  private lateinit var creatureEntityMapper: CreatureEntityMapper

  @Before
  fun setUp() {
    creatureEntityMapper = CreatureEntityMapper()
  }

  @Test
  fun mapToCachedMapsData() {
    val creatureEntity = CachedCreatureFactory.makeCreatureEntity()
    val cachedCreature = creatureEntityMapper.mapToCached(creatureEntity)

    assertCreatureDataEquality(creatureEntity, cachedCreature)
  }

  @Test
  fun mapFromCachedMapsData() {
    val cachedCreature = CachedCreatureFactory.makeCachedCreature()
    val creatureEntity = creatureEntityMapper.mapFromCached(cachedCreature)

    assertCreatureDataEquality(creatureEntity, cachedCreature)
  }

  private fun assertCreatureDataEquality(creatureEntity: CreatureEntity,
                                         cachedCreature: CachedCreature) {
    assertEquals(cachedCreature.firstName, creatureEntity.firstName)
    assertEquals(cachedCreature.lastName, creatureEntity.lastName)
    assertEquals(cachedCreature.nickname, creatureEntity.nickname)
    assertEquals(cachedCreature.image, creatureEntity.image)
    assertEquals(cachedCreature.planet, creatureEntity.planet)
  }
}