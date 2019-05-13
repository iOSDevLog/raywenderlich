package com.raywenderlich.android.creatures.data.mapper


/**
 * Interface for model mappers. It provides helper methods that facilitate
 * retrieving models from outer data source layers
 *
 * @param <E> the entity model input type
 * @param <D> the data model return type
 */
interface Mapper<E, D> {
  fun mapFromEntity(type: E): D
  fun mapToEntity(type: D): E
}