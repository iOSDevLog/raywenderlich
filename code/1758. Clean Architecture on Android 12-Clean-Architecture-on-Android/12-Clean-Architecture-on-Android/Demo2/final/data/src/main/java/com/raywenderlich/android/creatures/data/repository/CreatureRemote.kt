package com.raywenderlich.android.creatures.data.repository

import com.raywenderlich.android.creatures.data.model.CreatureEntity
import io.reactivex.Flowable


/**
 * Interface defining methods for the retrieving remote Creatures. This is to be implemented by the
 * remote layer, using this interface as a way of communicating.
 */
interface CreatureRemote {

  /**
   * Retrieve a list of Creatures, from the remote
   */
  fun getCreatures(): Flowable<List<CreatureEntity>>
}