package com.raywenderlich.android.creatures.data.source

import com.nhaarman.mockito_kotlin.mock
import com.nhaarman.mockito_kotlin.whenever
import com.raywenderlich.android.creatures.data.model.CreatureEntity
import com.raywenderlich.android.creatures.data.repository.CreatureRemote
import com.raywenderlich.android.creatures.data.test.factory.CreatureEntityFactory
import io.reactivex.Flowable
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4


@RunWith(JUnit4::class)
class CreatureRemoteDataStoreTest {

  private lateinit var creatureRemoteDataStore: CreatureRemoteDataStore

  private lateinit var creatureRemote: CreatureRemote

  @Before
  fun setUp() {
    creatureRemote = mock()
    creatureRemoteDataStore = CreatureRemoteDataStore(creatureRemote)
  }

  @Test(expected = UnsupportedOperationException::class)
  fun clearCreaturesThrowsException() {
    creatureRemoteDataStore.clearCreatures().test()
  }

  @Test(expected = UnsupportedOperationException::class)
  fun saveCreaturesThrowsException() {
    creatureRemoteDataStore.saveCreatures(CreatureEntityFactory.makeCreatureEntityList(2)).test()
  }

  @Test
  fun getCreaturesCompletes() {
    stubCreatureCacheGetCreatures(Flowable.just(CreatureEntityFactory.makeCreatureEntityList(2)))
    val testObserver = creatureRemote.getCreatures().test()
    testObserver.assertComplete()
  }

  private fun stubCreatureCacheGetCreatures(single: Flowable<List<CreatureEntity>>) {
    whenever(creatureRemote.getCreatures())
        .thenReturn(single)
  }
}