package com.raywenderlich.android.creatures.data

import com.nhaarman.mockito_kotlin.*
import com.raywenderlich.android.creatures.data.mapper.CreatureMapper
import com.raywenderlich.android.creatures.data.model.CreatureEntity
import com.raywenderlich.android.creatures.data.repository.CreatureDataStore
import com.raywenderlich.android.creatures.data.source.CreatureCacheDataStore
import com.raywenderlich.android.creatures.data.source.CreatureDataStoreFactory
import com.raywenderlich.android.creatures.data.source.CreatureRemoteDataStore
import com.raywenderlich.android.creatures.data.test.factory.CreatureEntityFactory
import com.raywenderlich.android.creatures.domain.model.Creature
import io.reactivex.Completable
import io.reactivex.Flowable
import io.reactivex.Single
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4


@RunWith(JUnit4::class)
class CreatureDataRepositoryTest {

  private lateinit var creatureDataRepository: CreatureDataRepository

  private lateinit var creatureDataStoreFactory: CreatureDataStoreFactory
  private lateinit var creatureMapper: CreatureMapper
  private lateinit var creatureCacheDataStore: CreatureCacheDataStore
  private lateinit var creatureRemoteDataStore: CreatureRemoteDataStore

  @Before
  fun setUp() {
    creatureDataStoreFactory = mock()
    creatureMapper = mock()
    creatureCacheDataStore = mock()
    creatureRemoteDataStore = mock()
    creatureDataRepository = CreatureDataRepository(creatureDataStoreFactory, creatureMapper)
    stubCreatureDataStoreFactoryRetrieveCacheDataStore()
    stubCreatureDataStoreFactoryRetrieveRemoteDataStore()
  }

  @Test
  fun clearCreaturesCompletes() {
    stubCreatureCacheClearCreatures(Completable.complete())
    val testObserver = creatureDataRepository.clearCreatures().test()
    testObserver.assertComplete()
  }

  @Test
  fun clearCreaturesCallsCacheDataStore() {
    stubCreatureCacheClearCreatures(Completable.complete())
    creatureDataRepository.clearCreatures().test()
    verify(creatureCacheDataStore).clearCreatures()
  }

  @Test
  fun clearCreaturesNeverCallsRemoteDataStore() {
    stubCreatureCacheClearCreatures(Completable.complete())
    creatureDataRepository.clearCreatures().test()
    verify(creatureRemoteDataStore, never()).clearCreatures()
  }

  @Test
  fun saveCreaturesCompletes() {
    stubCreatureCacheSaveCreatures(Completable.complete())
    val testObserver = creatureDataRepository.saveCreatures(
        CreatureEntityFactory.makeCreatureList(2)).test()
    testObserver.assertComplete()
  }

  @Test
  fun saveCreaturesCallsCacheDataStore() {
    stubCreatureCacheSaveCreatures(Completable.complete())
    creatureDataRepository.saveCreatures(CreatureEntityFactory.makeCreatureList(2)).test()
    verify(creatureCacheDataStore).saveCreatures(any())
  }

  @Test
  fun saveCreaturesNeverCallsRemoteDataStore() {
    stubCreatureCacheSaveCreatures(Completable.complete())
    creatureDataRepository.saveCreatures(CreatureEntityFactory.makeCreatureList(2)).test()
    verify(creatureRemoteDataStore, never()).saveCreatures(any())
  }

  @Test
  fun getCreaturesCompletes() {
    stubCreatureCacheDataStoreIsCached(Single.just(true))
    stubCreatureDataStoreFactoryRetrieveDataStore(creatureCacheDataStore)
    stubCreatureCacheDataStoreGetCreatures(Flowable.just(
        CreatureEntityFactory.makeCreatureEntityList(2)))
    stubCreatureCacheSaveCreatures(Completable.complete())
    val testObserver = creatureDataRepository.getCreatures().test()
    testObserver.assertComplete()
  }

  @Test
  fun getCreaturesReturnsData() {
    stubCreatureCacheDataStoreIsCached(Single.just(true))
    stubCreatureDataStoreFactoryRetrieveDataStore(creatureCacheDataStore)
    stubCreatureCacheSaveCreatures(Completable.complete())
    val creatures = CreatureEntityFactory.makeCreatureList(2)
    val creatureEntities = CreatureEntityFactory.makeCreatureEntityList(2)
    creatures.forEachIndexed { index, creature ->
      stubCreatureMapperMapFromEntity(creatureEntities[index], creature) }
    stubCreatureCacheDataStoreGetCreatures(Flowable.just(creatureEntities))

    val testObserver = creatureDataRepository.getCreatures().test()
    testObserver.assertValue(creatures)
  }

  @Test
  fun getCreaturesSavesCreaturesWhenFromCacheDataStore() {
    stubCreatureDataStoreFactoryRetrieveDataStore(creatureCacheDataStore)
    stubCreatureCacheSaveCreatures(Completable.complete())
    creatureDataRepository.saveCreatures(CreatureEntityFactory.makeCreatureList(2)).test()
    verify(creatureCacheDataStore).saveCreatures(any())
  }

  @Test
  fun getCreaturesNeverSavesCreaturesWhenFromRemoteDataStore() {
    stubCreatureDataStoreFactoryRetrieveDataStore(creatureRemoteDataStore)
    stubCreatureCacheSaveCreatures(Completable.complete())
    creatureDataRepository.saveCreatures(CreatureEntityFactory.makeCreatureList(2)).test()
    verify(creatureRemoteDataStore, never()).saveCreatures(any())
  }

  // TODO: Add getJupiterCreaturesReturnsData

  private fun stubCreatureCacheSaveCreatures(completable: Completable) {
    whenever(creatureCacheDataStore.saveCreatures(any()))
        .thenReturn(completable)
  }

  private fun stubCreatureCacheDataStoreIsCached(single: Single<Boolean>) {
    whenever(creatureCacheDataStore.isCached())
        .thenReturn(single)
  }

  private fun stubCreatureCacheDataStoreGetCreatures(single: Flowable<List<CreatureEntity>>) {
    whenever(creatureCacheDataStore.getCreatures())
        .thenReturn(single)
  }

  private fun stubCreatureRemoteDataStoreGetCreatures(single: Flowable<List<CreatureEntity>>) {
    whenever(creatureRemoteDataStore.getCreatures())
        .thenReturn(single)
  }

  private fun stubCreatureCacheClearCreatures(completable: Completable) {
    whenever(creatureCacheDataStore.clearCreatures())
        .thenReturn(completable)
  }

  private fun stubCreatureDataStoreFactoryRetrieveCacheDataStore() {
    whenever(creatureDataStoreFactory.retrieveCacheDataStore())
        .thenReturn(creatureCacheDataStore)
  }

  private fun stubCreatureDataStoreFactoryRetrieveRemoteDataStore() {
    whenever(creatureDataStoreFactory.retrieveRemoteDataStore())
        .thenReturn(creatureCacheDataStore)
  }

  private fun stubCreatureDataStoreFactoryRetrieveDataStore(dataStore: CreatureDataStore) {
    whenever(creatureDataStoreFactory.retrieveDataStore(any()))
        .thenReturn(dataStore)
  }

  private fun stubCreatureMapperMapFromEntity(creatureEntity: CreatureEntity,
                                              creature: Creature) {
    whenever(creatureMapper.mapFromEntity(creatureEntity))
        .thenReturn(creature)
  }
}