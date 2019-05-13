package com.raywenderlich.android.creatures.ui.model


/**
 * Representation for a [CreatureViewModel] fetched from an external layer data source
 */
class CreatureViewModel(val firstName: String,
                        val lastName: String,
                        val nickname: String,
                        val image: String,
                        val planet: String) {
  val fullName: String
    get() = firstName + " " + lastName
}