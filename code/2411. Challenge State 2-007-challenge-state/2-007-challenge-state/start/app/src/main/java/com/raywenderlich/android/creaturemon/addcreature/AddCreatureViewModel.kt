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

package com.raywenderlich.android.creaturemon.addcreature

import androidx.lifecycle.ViewModel
import com.raywenderlich.android.creaturemon.addcreature.AddCreatureResult.*
import com.raywenderlich.android.creaturemon.data.model.CreatureAttributes
import com.raywenderlich.android.creaturemon.data.model.CreatureGenerator
import com.raywenderlich.android.creaturemon.mvibase.MviViewModel
import io.reactivex.Observable
import io.reactivex.functions.BiFunction

class AddCreatureViewModel(
    private val actionProcessorHolder: AddCreatureProcessorHolder
) : ViewModel(), MviViewModel<AddCreatureIntent, AddCreatureViewState> {

  override fun processIntents(intents: Observable<AddCreatureIntent>) {
    TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
  }

  override fun states(): Observable<AddCreatureViewState> {
    TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
  }

  companion object {
    private val generator = CreatureGenerator()

    private val reducer = BiFunction { previousState: AddCreatureViewState, result: AddCreatureResult ->
      when (result) {
        is AvatarResult -> reduceAvatar(previousState, result)
        is NameResult -> reduceName(previousState, result)
        is IntelligenceResult -> reduceIntelligence(previousState, result)
        is StrengthResult -> reduceStrength(previousState, result)
        is EnduranceResult -> { }
        is SaveResult -> reduceSave(previousState, result)
      }
    }

    private fun reduceAvatar(
        previousState: AddCreatureViewState,
        result: AvatarResult)
        : AddCreatureViewState = when (result) {
      is AvatarResult.Success -> {
        previousState.copy(
            isProcessing = false,
            error = null,
            creature = generator.generateCreature(
                previousState.creature.attributes, previousState.creature.name, result.drawable),
            isDrawableSelected = (result.drawable != 0))
      }
      is AvatarResult.Failure -> {
        previousState.copy(isProcessing = false, error = result.error)
      }
      is AvatarResult.Processing -> {
        previousState.copy(isProcessing = true, error = null)
      }
    }

    private fun reduceName(
        previousState: AddCreatureViewState,
        result: NameResult)
        : AddCreatureViewState = when (result) {
      is NameResult.Success -> {
        previousState.copy(
            isProcessing = false,
            error = null,
            creature = generator.generateCreature(
                previousState.creature.attributes, result.name, previousState.creature.drawable))
      }
      is NameResult.Failure -> {
        previousState.copy(isProcessing = false, error = result.error)
      }
      is NameResult.Processing -> {
        previousState.copy(isProcessing = true, error = null)
      }
    }

    private fun reduceIntelligence(
        previousState: AddCreatureViewState,
        result: IntelligenceResult)
        : AddCreatureViewState = when (result) {
      is IntelligenceResult.Success -> {
        val attributes = CreatureAttributes(
            result.intelligence,
            previousState.creature.attributes.strength,
            previousState.creature.attributes.endurance)
        previousState.copy(
            isProcessing = false,
            error = null,
            creature = generator.generateCreature(
                attributes, previousState.creature.name, previousState.creature.drawable))
      }
      is IntelligenceResult.Failure -> {
        previousState.copy(isProcessing = false, error = result.error)
      }
      is IntelligenceResult.Processing -> {
        previousState.copy(isProcessing = true, error = null)
      }
    }

    private fun reduceStrength(
        previousState: AddCreatureViewState,
        result: StrengthResult)
        : AddCreatureViewState = when (result) {
      is StrengthResult.Success -> {
        val attributes = CreatureAttributes(
            previousState.creature.attributes.intelligence,
            result.strength,
            previousState.creature.attributes.endurance)
        previousState.copy(
            isProcessing = false,
            error = null,
            creature = generator.generateCreature(
                attributes, previousState.creature.name, previousState.creature.drawable))
      }
      is StrengthResult.Failure -> {
        previousState.copy(isProcessing = false, error = result.error)
      }
      is StrengthResult.Processing -> {
        previousState.copy(isProcessing = true, error = null)
      }
    }

    private fun reduceSave(
        previousState: AddCreatureViewState,
        result: SaveResult)
        : AddCreatureViewState = when (result) {
      is SaveResult.Success -> {
        previousState.copy(isProcessing = false, isSaveComplete = true, error = null)
      }
      is SaveResult.Failure -> {
        previousState.copy(isProcessing = false, error = result.error)
      }
      is SaveResult.Processing -> {
        previousState.copy(isProcessing = true, error = null)
      }
    }
  }
}