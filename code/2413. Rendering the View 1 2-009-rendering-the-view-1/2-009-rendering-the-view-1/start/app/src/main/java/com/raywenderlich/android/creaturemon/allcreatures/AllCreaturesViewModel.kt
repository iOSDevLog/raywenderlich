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

import androidx.lifecycle.ViewModel
import com.raywenderlich.android.creaturemon.allcreatures.AllCreaturesAction.ClearAllCreaturesAction
import com.raywenderlich.android.creaturemon.allcreatures.AllCreaturesAction.LoadAllCreaturesAction
import com.raywenderlich.android.creaturemon.allcreatures.AllCreaturesIntent.ClearAllCreaturesIntent
import com.raywenderlich.android.creaturemon.allcreatures.AllCreaturesIntent.LoadAllCreaturesIntent
import com.raywenderlich.android.creaturemon.allcreatures.AllCreaturesResult.ClearAllCreaturesResult
import com.raywenderlich.android.creaturemon.allcreatures.AllCreaturesResult.LoadAllCreaturesResult
import com.raywenderlich.android.creaturemon.mvibase.MviViewModel
import com.raywenderlich.android.creaturemon.util.notOfType
import io.reactivex.Observable
import io.reactivex.ObservableTransformer
import io.reactivex.functions.BiFunction
import io.reactivex.subjects.PublishSubject

class AllCreaturesViewModel(
    private val actionProcessorHolder: AllCreaturesProcessorHolder
) : ViewModel(), MviViewModel<AllCreaturesIntent, AllCreaturesViewState> {

  private val intentsSubject: PublishSubject<AllCreaturesIntent> = PublishSubject.create()
  private val statesObservable: Observable<AllCreaturesViewState> = compose()

  private val intentFilter: ObservableTransformer<AllCreaturesIntent, AllCreaturesIntent>
    get() = ObservableTransformer { intents ->
      intents.publish { shared ->
        Observable.merge(
            shared.ofType(AllCreaturesIntent.LoadAllCreaturesIntent::class.java).take(1),
            shared.notOfType(AllCreaturesIntent.LoadAllCreaturesIntent::class.java)
        )
      }
    }

  override fun processIntents(intents: Observable<AllCreaturesIntent>) {
    intents.subscribe(intentsSubject)
  }

  override fun states(): Observable<AllCreaturesViewState> = statesObservable

  private fun compose(): Observable<AllCreaturesViewState> {
    return intentsSubject
        .compose(intentFilter)
        .map(this::actionFromIntent)
        .compose(actionProcessorHolder.actionProcessor)
        .scan(AllCreaturesViewState.idle(), reducer)
        .distinctUntilChanged()
        .replay(1)
        .autoConnect(0)
  }

  private fun actionFromIntent(intent: AllCreaturesIntent): AllCreaturesAction {
    return when (intent) {
      is LoadAllCreaturesIntent -> LoadAllCreaturesAction
      is ClearAllCreaturesIntent -> ClearAllCreaturesAction
    }
  }

  companion object {
    private val reducer = BiFunction { previousState: AllCreaturesViewState, result: AllCreaturesResult ->
      when (result) {
        is LoadAllCreaturesResult -> when (result) {
          is LoadAllCreaturesResult.Success -> {
            previousState.copy(isLoading = false, creatures = result.creatures)
          }
          is LoadAllCreaturesResult.Failure -> previousState.copy(isLoading = false, error = result.error)
          is LoadAllCreaturesResult.Loading -> previousState.copy(isLoading = true)
        }
        is ClearAllCreaturesResult -> when (result) {
          is ClearAllCreaturesResult.Success -> {
            previousState.copy(isLoading = false, creatures = emptyList())
          }
          is ClearAllCreaturesResult.Failure -> previousState.copy(isLoading = false, error = result.error)
          is ClearAllCreaturesResult.Clearing -> previousState.copy(isLoading = true)
        }
      }
    }
  }
}