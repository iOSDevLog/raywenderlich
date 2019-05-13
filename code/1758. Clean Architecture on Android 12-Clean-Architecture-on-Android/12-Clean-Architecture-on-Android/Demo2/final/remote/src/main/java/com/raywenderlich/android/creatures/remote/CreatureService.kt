package com.raywenderlich.android.creatures.remote

import com.raywenderlich.android.creatures.remote.model.CreatureModel
import io.reactivex.Flowable
import retrofit2.http.GET

/**
 * Defines the abstract methods used for interacting with the Creature API
 */
interface CreatureService {

  @GET("creatures.json")
  fun getCreatures(): Flowable<CreatureResponse>

  class CreatureResponse {
    lateinit var creatures: List<CreatureModel>
  }
}