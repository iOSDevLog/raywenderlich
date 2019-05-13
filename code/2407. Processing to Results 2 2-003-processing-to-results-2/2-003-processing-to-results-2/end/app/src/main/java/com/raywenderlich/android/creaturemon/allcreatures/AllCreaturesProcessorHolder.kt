/*
 * Copyright (c) 2019 Razeware LLC
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

import com.raywenderlich.android.creaturemon.allcreatures.AllCreaturesAction.ClearAllCreaturesAction
import com.raywenderlich.android.creaturemon.allcreatures.AllCreaturesAction.LoadAllCreaturesAction
import com.raywenderlich.android.creaturemon.allcreatures.AllCreaturesResult.ClearAllCreaturesResult
import com.raywenderlich.android.creaturemon.allcreatures.AllCreaturesResult.LoadAllCreaturesResult
import com.raywenderlich.android.creaturemon.data.repository.CreatureRepository
import com.raywenderlich.android.creaturemon.util.schedulers.BaseSchedulerProvider
import io.reactivex.Observable
import io.reactivex.ObservableTransformer

class AllCreaturesProcessorHolder(
    private val creatureRepository: CreatureRepository,
    private val schedulerProvider: BaseSchedulerProvider
) {

  private val loadAllCreaturesProcessor =
      ObservableTransformer<LoadAllCreaturesAction, LoadAllCreaturesResult> { actions ->
        actions.flatMap {
          creatureRepository.getAllCreatures()
              .map { creatures -> LoadAllCreaturesResult.Success(creatures) }
              .cast(LoadAllCreaturesResult::class.java)
              .onErrorReturn(LoadAllCreaturesResult::Failure)
              .subscribeOn(schedulerProvider.io())
              .observeOn(schedulerProvider.ui())
              .startWith(LoadAllCreaturesResult.Loading)
        }
      }

  private val clearAllCreaturesProcessor =
      ObservableTransformer<ClearAllCreaturesAction, ClearAllCreaturesResult> { actions ->
        actions.flatMap {
          creatureRepository.clearAllCreatures()
              .map { ClearAllCreaturesResult.Success }
              .cast(ClearAllCreaturesResult::class.java)
              .onErrorReturn(ClearAllCreaturesResult::Failure)
              .subscribeOn(schedulerProvider.io())
              .observeOn(schedulerProvider.ui())
              .startWith(ClearAllCreaturesResult.Clearing)
        }
      }

  internal var actionProcessor =
      ObservableTransformer<AllCreaturesAction, AllCreaturesResult> { actions ->
        actions.publish { shared ->
          Observable.merge(
              shared.ofType(LoadAllCreaturesAction::class.java).compose(loadAllCreaturesProcessor),
              shared.ofType(ClearAllCreaturesAction::class.java).compose(clearAllCreaturesProcessor))
              .mergeWith(
                  // Error for not implemented actions
                  shared.filter { v ->
                    v !is LoadAllCreaturesAction
                        && v !is ClearAllCreaturesAction
                  }.flatMap { w ->
                    Observable.error<AllCreaturesResult>(
                        IllegalArgumentException("Unknown Action type: $w"))
                  }
              )
        }
      }
}