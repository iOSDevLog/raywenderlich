package com.raywenderlich.android.creatures.data.source

import com.nhaarman.mockito_kotlin.any
import com.nhaarman.mockito_kotlin.mock
import com.nhaarman.mockito_kotlin.whenever
import com.raywenderlich.android.creatures.data.model.CreatureEntity
import com.raywenderlich.android.creatures.data.repository.CreatureCache
import com.raywenderlich.android.creatures.data.test.factory.CreatureEntityFactory
import io.reactivex.Completable
import io.reactivex.Flowable
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4


@RunWith(JUnit4::class)
class CreatureCacheDataStoreTest {

  private lateinit var creatureCacheDataStore: CreatureCacheDataStore
  private lateinit var creatureCache: CreatureCache

  @Before
  fun setUp() {
    creatureCache = mock()
    creatureCacheDataStore = CreatureCacheDataStore(creatureCache)
  }

  @Test
  fun clearCreaturesCompletes() {
    stubCreatureCacheClearCreatures(Completable.complete())
    val testObserver = creatureCacheDataStore.clearCreatures().test()
    testObserver.assertComplete()
  }

  @Test
  fun saveCreaturesCompletes() {
    stubCreatureCacheSaveCreatures(Completable.complete())
    val testObserver = creatureCacheDataStore.saveCreatures(
        CreatureEntityFactory.makeCreatureEntityList(2)).test()
    testObserver.assertComplete()
  }

  @Test
  fun getCreaturesCompletes() {
    stubCreatureCacheGetCreatures(Flowable.just(CreatureEntityFactory.makeCreatureEntityList(2)))
    val testObserver = creatureCacheDataStore.getCreatures().test()
    testObserver.assertComplete()
  }

  private fun stubCreatureCacheSaveCreatures(completable: Completable) {
    whenever(creatureCache.saveCreatures(any()))
        .thenReturn(completable)
  }

  private fun stubCreatureCacheGetCreatures(single: Flowable<List<CreatureEntity>>) {
    whenever(creatureCache.getCreatures())
        .thenReturn(single)
  }

  private fun stubCreatureCacheClearCreatures(completable: Completable) {
    whenever(creatureCache.clearCreatures())
        .thenReturn(completable)
  }
}