package com.raywenderlich.android.creatures.remote.test.factory

import com.raywenderlich.android.creatures.remote.CreatureService
import com.raywenderlich.android.creatures.remote.model.CreatureModel
import com.raywenderlich.android.creatures.remote.test.factory.DataFactory.Factory.randomLong
import com.raywenderlich.android.creatures.remote.test.factory.DataFactory.Factory.randomUuid


/**
 * Factory class for CreatureModel related instances
 */
class CreatureModelFactory {

  companion object Factory {

    fun makeCreatureResponse(): CreatureService.CreatureResponse {
      val creatureResponse = CreatureService.CreatureResponse()
      creatureResponse.creatures = makeCreatureModelList(5)
      return creatureResponse
    }

    private fun makeCreatureModelList(count: Int): List<CreatureModel> {
      val creatureModels = mutableListOf<CreatureModel>()
      repeat(count) {
        creatureModels.add(makeCreatureModel())
      }
      return creatureModels
    }

    fun makeCreatureModel(): CreatureModel {
      return CreatureModel(randomLong(), randomUuid(), randomUuid(), randomUuid(), randomUuid(), randomUuid())
    }
  }
}