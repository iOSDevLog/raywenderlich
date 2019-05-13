package com.raywenderlich.android.creatures.cache.db.constants


/**
 * Defines constants for the Creatures Table
 */
object CreatureConstants {
  const val TABLE_NAME = "creatures"
  const val QUERY_CREATURES = "SELECT * FROM" + " " + TABLE_NAME
  const val DELETE_ALL_CREATURES = "DELETE FROM" + " " + TABLE_NAME
}