package com.raywenderlich.android.creatures.data.model


data class CreatureEntity(
    val id: Long,
    val firstName: String,
    val lastName: String,
    val nickname: String,
    val image: String,
    val planet: String)