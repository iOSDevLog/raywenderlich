package com.raywenderlich.android.creatures.cache.model

import android.arch.persistence.room.Entity
import android.arch.persistence.room.PrimaryKey
import com.raywenderlich.android.creatures.cache.db.constants.CreatureConstants


/**
 * Model used solely for the caching of a creature
 */
@Entity(tableName = CreatureConstants.TABLE_NAME)
data class CachedCreature(
    @PrimaryKey
    val id: Long,
    val firstName: String,
    val lastName: String,
    val nickname: String,
    val image: String,
    val planet: String
)