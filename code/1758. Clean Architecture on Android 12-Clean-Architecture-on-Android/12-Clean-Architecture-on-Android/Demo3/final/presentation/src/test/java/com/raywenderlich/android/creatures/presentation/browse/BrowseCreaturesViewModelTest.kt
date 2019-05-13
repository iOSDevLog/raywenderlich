package com.raywenderlich.android.creatures.presentation.browse

import android.arch.core.executor.testing.InstantTaskExecutorRule
import com.nhaarman.mockito_kotlin.*
import com.raywenderlich.android.creatures.domain.interactor.browse.GetCreatures
import com.raywenderlich.android.creatures.domain.interactor.browse.GetJupiterCreatures
import com.raywenderlich.android.creatures.domain.model.Creature
import com.raywenderlich.android.creatures.presentation.data.ResourceState
import com.raywenderlich.android.creatures.presentation.mapper.CreatureMapper
import com.raywenderlich.android.creatures.presentation.model.CreatureView
import com.raywenderlich.android.creatures.presentation.test.factory.CreatureFactory
import com.raywenderlich.android.creatures.presentation.test.factory.DataFactory
import io.reactivex.subscribers.DisposableSubscriber
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4
import org.mockito.Captor
import org.mockito.Mock

@RunWith(JUnit4::class)
class BrowseCreaturesViewModelTest {

  @get:Rule
  var instantTaskExecutorRule = InstantTaskExecutorRule()

  @Mock private lateinit var getCreatures: GetCreatures
  @Mock private lateinit var getJupiter: GetJupiterCreatures
  @Mock private lateinit var creatureMapper: CreatureMapper

  @Captor
  private lateinit var captor: KArgumentCaptor<DisposableSubscriber<List<Creature>>>

  private lateinit var creaturesViewModel: BrowseCreaturesViewModel

  @Before
  fun setUp() {
    captor = argumentCaptor()
    getCreatures = mock()
    getJupiter = mock()
    creatureMapper = mock()
    creaturesViewModel = BrowseCreaturesViewModel(getCreatures, getJupiter, creatureMapper)
  }

  @Test
  fun getCreaturesExecutesUseCase() {
    creaturesViewModel.getCreatures()

    verify(getCreatures, times(1)).execute(any(), anyOrNull())
  }

  @Test
  fun getCreaturesReturnsSuccess() {
    val list = CreatureFactory.makeCreatureList(2)
    val viewList = CreatureFactory.makeCreatureViewList(2)
    stubCreatureMapperMapToView(viewList[0], list[0])
    stubCreatureMapperMapToView(viewList[1], list[1])

    creaturesViewModel.getCreatures()

    verify(getCreatures).execute(captor.capture(), eq(null))
    captor.firstValue.onNext(list)

    assert(creaturesViewModel.getCreatures().value?.status == ResourceState.SUCCESS)
  }

  @Test
  fun getCreaturesReturnsDataOnSuccess() {
    val list = CreatureFactory.makeCreatureList(2)
    val viewList = CreatureFactory.makeCreatureViewList(2)

    stubCreatureMapperMapToView(viewList[0], list[0])
    stubCreatureMapperMapToView(viewList[1], list[1])

    creaturesViewModel.getCreatures()

    verify(getCreatures).execute(captor.capture(), eq(null))
    captor.firstValue.onNext(list)

    assert(creaturesViewModel.getCreatures().value?.data == viewList)
  }

  @Test
  fun getJupiterReturnsDataOnSuccess() {
    val list = CreatureFactory.makeJupiterCreatureList(2)
    val viewList = CreatureFactory.makeJupiterCreatureViewList(2)

    stubCreatureMapperMapToView(viewList[0], list[0])
    stubCreatureMapperMapToView(viewList[1], list[1])

    creaturesViewModel.getJupiter()

    verify(getJupiter).execute(captor.capture(), eq(null))
    captor.firstValue.onNext(list)

    assert(creaturesViewModel.getJupiter().value?.data == viewList)
  }

  @Test
  fun getCreaturesReturnsNoMessageOnSuccess() {
    val list = CreatureFactory.makeCreatureList(2)
    val viewList = CreatureFactory.makeCreatureViewList(2)

    stubCreatureMapperMapToView(viewList[0], list[0])
    stubCreatureMapperMapToView(viewList[1], list[1])

    creaturesViewModel.getCreatures()

    verify(getCreatures).execute(captor.capture(), eq(null))
    captor.firstValue.onNext(list)

    assert(creaturesViewModel.getCreatures().value?.message == null)
  }

  @Test
  fun getCreaturesReturnsError() {
    creaturesViewModel.getCreatures()

    verify(getCreatures).execute(captor.capture(), eq(null))
    captor.firstValue.onError(RuntimeException())

    assert(creaturesViewModel.getCreatures().value?.status == ResourceState.ERROR)
  }

  @Test
  fun getCreaturesFailsAndContainsNoData() {
    creaturesViewModel.getCreatures()

    verify(getCreatures).execute(captor.capture(), eq(null))
    captor.firstValue.onError(RuntimeException())

    assert(creaturesViewModel.getCreatures().value?.data == null)
  }

  @Test
  fun getCreaturesFailsAndContainsMessage() {
    val errorMessage = DataFactory.randomUuid()
    creaturesViewModel.getCreatures()

    verify(getCreatures).execute(captor.capture(), eq(null))
    captor.firstValue.onError(RuntimeException(errorMessage))

    assert(creaturesViewModel.getCreatures().value?.message == errorMessage)
  }

  @Test
  fun getCreaturesReturnsLoading() {
    creaturesViewModel.getCreatures()

    assert(creaturesViewModel.getCreatures().value?.status == ResourceState.LOADING)
  }

  @Test
  fun getCreaturesContainsNoDataWhenLoading() {
    creaturesViewModel.getCreatures()

    assert(creaturesViewModel.getCreatures().value?.data == null)
  }

  @Test
  fun getCreaturesContainsNoMessageWhenLoading() {
    creaturesViewModel.getCreatures()

    assert(creaturesViewModel.getCreatures().value?.data == null)
  }

  private fun stubCreatureMapperMapToView(creatureView: CreatureView,
                                          creature: Creature) {
    whenever(creatureMapper.mapToView(creature))
        .thenReturn(creatureView)
  }
}