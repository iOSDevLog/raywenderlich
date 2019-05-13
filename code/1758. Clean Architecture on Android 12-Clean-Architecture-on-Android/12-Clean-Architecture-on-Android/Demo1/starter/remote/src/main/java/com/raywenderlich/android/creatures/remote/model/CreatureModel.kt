package com.raywenderlich.android.creatures.remote.model


/**
 * Representation of a [CreatureModel] fetched from the API
 */
class CreatureModel(
    val id: Long,
    val firstName: String,
    val lastName: String,
    val nickname: String,
    val image: String,
    val planet: String)