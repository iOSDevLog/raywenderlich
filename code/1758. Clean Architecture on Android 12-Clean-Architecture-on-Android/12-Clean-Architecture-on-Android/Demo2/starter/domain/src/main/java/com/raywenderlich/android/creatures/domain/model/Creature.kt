package com.raywenderlich.android.creatures.domain.model


data class Creature(
    val id: Long,
    val firstName: String,
    val lastName: String,
    val nickname: String,
    val image: String,
    val planet: String)