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
 */

package com.raywenderlich.android.creaturemon.allcreatures

import com.raywenderlich.android.creaturemon.data.model.Creature
import com.raywenderlich.android.creaturemon.data.model.CreatureAttributes
import com.raywenderlich.android.creaturemon.data.model.CreatureGenerator
import com.raywenderlich.android.creaturemon.data.repository.CreatureRepository
import com.raywenderlich.android.creaturemon.util.schedulers.BaseSchedulerProvider
import com.raywenderlich.android.creaturemon.util.schedulers.ImmediateSchedulerProvider
import io.reactivex.Observable
import io.reactivex.observers.TestObserver
import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.Mockito.`when`
import org.mockito.MockitoAnnotations


class AllCreaturesViewModelTest {

  @Mock
  private lateinit var creatureRepository: CreatureRepository
  private lateinit var schedulerProvider: BaseSchedulerProvider
  private lateinit var generator: CreatureGenerator
  private lateinit var viewModel: AllCreaturesViewModel
  private lateinit var testObserver: TestObserver<AllCreaturesViewState>
  private lateinit var creatures: List<Creature>

  @Before
  fun setup() {
    MockitoAnnotations.initMocks(this)

    schedulerProvider = ImmediateSchedulerProvider()

    generator = CreatureGenerator()

    viewModel = AllCreaturesViewModel(AllCreaturesProcessorHolder(creatureRepository, schedulerProvider))

    creatures = listOf(
        generator.generateCreature(CreatureAttributes(3, 7, 10), "Creature 1", 1),
        generator.generateCreature(CreatureAttributes(7, 10, 3), "Creature 2", 1),
        generator.generateCreature(CreatureAttributes(10, 3, 7), "Creature 3", 1)
    )

    testObserver = viewModel.states().test()
  }


  @Test
  fun loadAllCreaturesFromRepositoryAndLoadIntoView() {
    `when`(creatureRepository.getAllCreatures()).thenReturn(Observable.just(creatures))

    viewModel.processIntents(Observable.just(AllCreaturesIntent.LoadAllCreaturesIntent))

    testObserver.assertValueAt(1, AllCreaturesViewState::isLoading)
    testObserver.assertValueAt(2) { allCreaturesViewState: AllCreaturesViewState ->  !allCreaturesViewState.isLoading }
  }

  @Test
  fun errorLoadingCreaturesShowsError() {
    `when`(creatureRepository.getAllCreatures()).thenReturn(Observable.error(Exception()))

    viewModel.processIntents(Observable.just(AllCreaturesIntent.LoadAllCreaturesIntent))

    testObserver.assertValueAt(2) { state -> state.error != null }
  }
}