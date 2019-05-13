package com.raywenderlich.android.creatures.remote.mapper

import com.raywenderlich.android.creatures.remote.test.factory.CreatureModelFactory
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
  fun mapFromRemoteMapsData() {
    val creatureModel = CreatureModelFactory.makeCreatureModel()
    val creatureEntity = creatureEntityMapper.mapFromRemote(creatureModel)

    assertEquals(creatureModel.firstName, creatureEntity.firstName)
    assertEquals(creatureModel.lastName, creatureEntity.lastName)
    assertEquals(creatureModel.nickname, creatureEntity.nickname)
    assertEquals(creatureModel.image, creatureEntity.image)
    assertEquals(creatureModel.planet, creatureEntity.planet)
  }
}