package com.raywenderlich.android.creatures.domain.usecase.jupitercreatures

import com.nhaarman.mockito_kotlin.mock
import com.nhaarman.mockito_kotlin.verify
import com.nhaarman.mockito_kotlin.whenever
import com.raywenderlich.android.creatures.domain.executor.PostExecutionThread
import com.raywenderlich.android.creatures.domain.executor.ThreadExecutor
import com.raywenderlich.android.creatures.domain.interactor.browse.GetJupiterCreatures
import com.raywenderlich.android.creatures.domain.model.Creature
import com.raywenderlich.android.creatures.domain.repository.CreatureRepository
import com.raywenderlich.android.creatures.domain.test.factory.CreatureFactory
import io.reactivex.Flowable
import org.junit.Before
import org.junit.Test

class GetJupiterCreaturesTest {

  private lateinit var getJupiterCreatures: GetJupiterCreatures

  private lateinit var mockThreadExecutor: ThreadExecutor
  private lateinit var mockPostExecutionThread: PostExecutionThread
  private lateinit var mockCreatureRepository: CreatureRepository

  @Before
  fun setUp() {
    mockThreadExecutor = mock()
    mockPostExecutionThread = mock()
    mockCreatureRepository = mock()
    getJupiterCreatures = GetJupiterCreatures(mockCreatureRepository, mockThreadExecutor, mockPostExecutionThread)
  }

  @Test
  fun buildUseCaseObservableCallsRepository() {
    getJupiterCreatures.buildUseCaseObservable(null)
    verify(mockCreatureRepository).getJupiterCreatures()
  }

  @Test
  fun buildUseCaseObservableCompletes() {
    stubCreatureRepositoryGetCreatures(Flowable.just(CreatureFactory.makeJupiterCreatureList(2)))
    val testObserver = getJupiterCreatures.buildUseCaseObservable(null).test()
    testObserver.assertComplete()
  }

  @Test
  fun buildUseCaseObservableReturnsData() {
    val creatures = CreatureFactory.makeJupiterCreatureList(2)
    stubCreatureRepositoryGetCreatures(Flowable.just(creatures))
    val testObserver = getJupiterCreatures.buildUseCaseObservable(null).test()
    testObserver.assertValue(creatures.filter { it.planet == "Jupiter" })
  }

  private fun stubCreatureRepositoryGetCreatures(single: Flowable<List<Creature>>) {
    whenever(mockCreatureRepository.getJupiterCreatures())
        .thenReturn(single)
  }
}