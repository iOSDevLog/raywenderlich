package com.raywenderlich.android.creatures.remote

import com.nhaarman.mockito_kotlin.mock
import com.nhaarman.mockito_kotlin.whenever
import com.raywenderlich.android.creatures.data.model.CreatureEntity
import com.raywenderlich.android.creatures.remote.mapper.CreatureEntityMapper
import com.raywenderlich.android.creatures.remote.test.factory.CreatureModelFactory
import io.reactivex.Flowable
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4

@RunWith(JUnit4::class)
class CreatureRemoteImplTest {

  private lateinit var entityMapper: CreatureEntityMapper
  private lateinit var creatureService: CreatureService

  private lateinit var creatureRemoteImpl: CreatureRemoteImpl

  @Before
  fun setup() {
    entityMapper = mock()
    creatureService = mock()
    creatureRemoteImpl = CreatureRemoteImpl(creatureService, entityMapper)
  }

  @Test
  fun getCreaturesCompletes() {
    stubCreatureServiceGetCreatures(Flowable.just(CreatureModelFactory.makeCreatureResponse()))
    val testObserver = creatureRemoteImpl.getCreatures().test()
    testObserver.assertComplete()
  }

  @Test
  fun getCreaturesReturnsData() {
    val creatureResponse = CreatureModelFactory.makeCreatureResponse()
    stubCreatureServiceGetCreatures(Flowable.just(creatureResponse))
    val creatureEntities = mutableListOf<CreatureEntity>()
    creatureResponse.creatures.forEach {
      creatureEntities.add(entityMapper.mapFromRemote(it))
    }

    val testObserver = creatureRemoteImpl.getCreatures().test()
    testObserver.assertValue(creatureEntities)
  }

  private fun stubCreatureServiceGetCreatures(observable:
                                              Flowable<CreatureService.CreatureResponse>) {
    whenever(creatureService.getCreatures())
        .thenReturn(observable)
  }
}