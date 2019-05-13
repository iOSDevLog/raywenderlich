/*
 * Copyright (c) 2018 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

package com.raywenderlich.android.creatures.domain.usecase.jupitercreatures

import com.nhaarman.mockito_kotlin.mock
import com.nhaarman.mockito_kotlin.verify
import com.nhaarman.mockito_kotlin.whenever
import com.raywenderlich.android.creatures.domain.executor.PostExecutionThread
import com.raywenderlich.android.creatures.domain.executor.ThreadExecutor
import com.raywenderlich.android.creatures.domain.model.Creature
import com.raywenderlich.android.creatures.domain.repository.CreatureRepository
import com.raywenderlich.android.creatures.domain.test.factory.CreatureFactory
import io.reactivex.Flowable
import org.junit.Before
import org.junit.Test

// TODO
//class GetJupiterCreaturesTest {
//
//  private lateinit var getJupiterCreatures: GetJupiterCreatures
//
//  private lateinit var mockThreadExecutor: ThreadExecutor
//  private lateinit var mockPostExecutionThread: PostExecutionThread
//  private lateinit var mockCreatureRepository: CreatureRepository
//
//  @Before
//  fun setUp() {
//    mockThreadExecutor = mock()
//    mockPostExecutionThread = mock()
//    mockCreatureRepository = mock()
//    getJupiterCreatures = GetJupiterCreatures(mockCreatureRepository,
//        mockThreadExecutor,
//        mockPostExecutionThread)
//  }
//
//  @Test
//  fun buildUseCaseObservableCallsRepository() {
//    getJupiterCreatures.buildUseCaseObservable(null)
//    verify(mockCreatureRepository).getJupiterCreatures()
//  }
//
//  @Test
//  fun buildUseCaseObservableCompletes() {
//    stubCreatureRepositoryGetCreatures(
//        Flowable.just(CreatureFactory.makeJupiterCreatureList(2)))
//    val testObserver = getJupiterCreatures
//        .buildUseCaseObservable(null)
//        .test()
//    testObserver.assertComplete()
//  }
//
//  @Test
//  fun buildUseCaseObservableReturnsData() {
//    val creatures = CreatureFactory.makeJupiterCreatureList(2)
//    stubCreatureRepositoryGetCreatures(Flowable.just(creatures))
//    val testObserver = getJupiterCreatures
//        .buildUseCaseObservable(null)
//        .test()
//    testObserver.assertValue(creatures.filter {
//      it.planet == "Jupiter"
//    })
//  }
//
//  private fun stubCreatureRepositoryGetCreatures(single: Flowable<List<Creature>>) {
//    whenever(mockCreatureRepository.getJupiterCreatures())
//        .thenReturn(single)
//  }
//}