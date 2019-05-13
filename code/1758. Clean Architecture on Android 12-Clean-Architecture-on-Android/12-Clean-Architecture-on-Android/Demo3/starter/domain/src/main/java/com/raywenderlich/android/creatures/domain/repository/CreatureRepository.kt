package com.raywenderlich.android.creatures.domain.repository

import com.raywenderlich.android.creatures.domain.model.Creature
import io.reactivex.Completable
import io.reactivex.Flowable

/**
 * Interface defining methods for how the data layer can pass data to and from the Domain layer.
 * This is to be implemented by the data layer, setting the requirements for the
 * operations that need to be implemented
 */
interface CreatureRepository {
  fun clearCreatures(): Completable
  fun saveCreatures(creatures: List<Creature>): Completable
  fun getCreatures(): Flowable<List<Creature>>
  fun getJupiterCreatures(): Flowable<List<Creature>>
}
