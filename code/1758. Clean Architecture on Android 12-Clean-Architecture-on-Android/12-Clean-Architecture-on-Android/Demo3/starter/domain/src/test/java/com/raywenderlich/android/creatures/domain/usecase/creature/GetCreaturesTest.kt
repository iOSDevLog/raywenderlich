package com.raywenderlich.android.creatures.domain.usecase.creature

import com.nhaarman.mockito_kotlin.mock
import com.nhaarman.mockito_kotlin.verify
import com.nhaarman.mockito_kotlin.whenever
import com.raywenderlich.android.creatures.domain.executor.PostExecutionThread
import com.raywenderlich.android.creatures.domain.executor.ThreadExecutor
import com.raywenderlich.android.creatures.domain.interactor.browse.GetCreatures
import com.raywenderlich.android.creatures.domain.model.Creature
import com.raywenderlich.android.creatures.domain.repository.CreatureRepository
import com.raywenderlich.android.creatures.domain.test.factory.CreatureFactory
import io.reactivex.Flowable
import org.junit.Before
import org.junit.Test


class GetCreaturesTest {

  private lateinit var getCreatures: GetCreatures

  private lateinit var mockThreadExecutor: ThreadExecutor
  private lateinit var mockPostExecutionThread: PostExecutionThread
  private lateinit var mockCreatureRepository: CreatureRepository

  @Before
  fun setUp() {
    mockThreadExecutor = mock()
    mockPostExecutionThread = mock()
    mockCreatureRepository = mock()
    getCreatures = GetCreatures(mockCreatureRepository, mockThreadExecutor, mockPostExecutionThread)
  }

  @Test
  fun buildUseCaseObservableCallsRepository() {
    getCreatures.buildUseCaseObservable(null)
    verify(mockCreatureRepository).getCreatures()
  }

  @Test
  fun buildUseCaseObservableCompletes() {
    stubCreatureRepositoryGetCreatures(Flowable.just(CreatureFactory.makeCreatureList(2)))
    val testObserver = getCreatures.buildUseCaseObservable(null).test()
    testObserver.assertComplete()
  }

  @Test
  fun buildUseCaseObservableReturnsData() {
    val creatures = CreatureFactory.makeCreatureList(2)
    stubCreatureRepositoryGetCreatures(Flowable.just(creatures))
    val testObserver = getCreatures.buildUseCaseObservable(null).test()
    testObserver.assertValue(creatures)
  }

  private fun stubCreatureRepositoryGetCreatures(single: Flowable<List<Creature>>) {
    whenever(mockCreatureRepository.getCreatures())
        .thenReturn(single)
  }
}