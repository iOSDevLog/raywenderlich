package com.raywenderlich.android.creatures.ui.test.mapper

import com.raywenderlich.android.creatures.ui.mapper.CreatureMapper
import com.raywenderlich.android.creatures.ui.test.factory.CreatureFactory
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
  fun mapToViewMapsData() {
    val creatureView = CreatureFactory.makeCreatureView()
    val creatureViewModel = creatureMapper.mapToViewModel(creatureView)

    assertEquals(creatureView.firstName, creatureViewModel.firstName)
    assertEquals(creatureView.lastName, creatureViewModel.lastName)
    assertEquals(creatureView.nickname, creatureViewModel.nickname)
    assertEquals(creatureView.image, creatureViewModel.image)
    assertEquals(creatureView.planet, creatureViewModel.planet)
  }
}