package com.raywenderlich.android.creatures.cache.dao

import android.arch.persistence.room.Dao
import android.arch.persistence.room.Insert
import android.arch.persistence.room.OnConflictStrategy
import android.arch.persistence.room.Query
import com.raywenderlich.android.creatures.cache.db.constants.CreatureConstants
import com.raywenderlich.android.creatures.cache.model.CachedCreature


@Dao
abstract class CachedCreatureDao {

  @Query(CreatureConstants.QUERY_CREATURES)
  abstract fun getCreatures(): List<CachedCreature>

  @Query(CreatureConstants.DELETE_ALL_CREATURES)
  abstract fun clearCreatures()

  @Insert(onConflict = OnConflictStrategy.REPLACE)
  abstract fun insertCreature(cachedCreature: CachedCreature)
}