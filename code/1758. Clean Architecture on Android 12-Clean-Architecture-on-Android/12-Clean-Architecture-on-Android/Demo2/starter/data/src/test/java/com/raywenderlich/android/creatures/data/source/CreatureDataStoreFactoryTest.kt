package com.raywenderlich.android.creatures.data.source

import com.nhaarman.mockito_kotlin.mock
import com.nhaarman.mockito_kotlin.whenever
import com.raywenderlich.android.creatures.data.repository.CreatureCache
import io.reactivex.Single
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4


@RunWith(JUnit4::class)
class CreatureDataStoreFactoryTest {

  private lateinit var creatureDataStoreFactory: CreatureDataStoreFactory

  private lateinit var creatureCache: CreatureCache
  private lateinit var creatureCacheDataStore: CreatureCacheDataStore
  private lateinit var creatureRemoteDataStore: CreatureRemoteDataStore

  @Before
  fun setUp() {
    creatureCache = mock()
    creatureCacheDataStore = mock()
    creatureRemoteDataStore = mock()
    creatureDataStoreFactory = CreatureDataStoreFactory(creatureCache,
        creatureCacheDataStore, creatureRemoteDataStore)
  }

  @Test
  fun retrieveDataStoreWhenNotCachedReturnsRemoteDataStore() {
    stubCreatureCacheIsCached(Single.just(false))
    val creatureDataStore = creatureDataStoreFactory.retrieveDataStore(false)
    assert(creatureDataStore is CreatureRemoteDataStore)
  }

  @Test
  fun retrieveDataStoreWhenCacheExpiredReturnsRemoteDataStore() {
    stubCreatureCacheIsCached(Single.just(true))
    stubCreatureCacheIsExpired(true)
    val creatureDataStore = creatureDataStoreFactory.retrieveDataStore(true)
    assert(creatureDataStore is CreatureRemoteDataStore)
  }

  @Test
  fun retrieveDataStoreReturnsCacheDataStore() {
    stubCreatureCacheIsCached(Single.just(true))
    stubCreatureCacheIsExpired(false)
    val creatureDataStore = creatureDataStoreFactory.retrieveDataStore(true)
    assert(creatureDataStore is CreatureCacheDataStore)
  }

  @Test
  fun retrieveRemoteDataStoreReturnsRemoteDataStore() {
    val creatureDataStore = creatureDataStoreFactory.retrieveRemoteDataStore()
    assert(creatureDataStore is CreatureRemoteDataStore)
  }

  @Test
  fun retrieveCacheDataStoreReturnsCacheDataStore() {
    val creatureDataStore = creatureDataStoreFactory.retrieveCacheDataStore()
    assert(creatureDataStore is CreatureCacheDataStore)
  }

  private fun stubCreatureCacheIsCached(single: Single<Boolean>) {
    whenever(creatureCache.isCached())
        .thenReturn(single)
  }

  private fun stubCreatureCacheIsExpired(isExpired: Boolean) {
    whenever(creatureCache.isExpired())
        .thenReturn(isExpired)
  }
}