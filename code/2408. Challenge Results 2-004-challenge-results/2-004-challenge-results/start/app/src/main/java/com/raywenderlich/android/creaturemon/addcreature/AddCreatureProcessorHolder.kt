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

import com.raywenderlich.android.creaturemon.addcreature.AddCreatureAction.*
import com.raywenderlich.android.creaturemon.addcreature.AddCreatureResult.*
import com.raywenderlich.android.creaturemon.data.model.AttributeStore
import com.raywenderlich.android.creaturemon.data.model.CreatureAttributes
import com.raywenderlich.android.creaturemon.data.model.CreatureGenerator
import com.raywenderlich.android.creaturemon.data.repository.CreatureRepository
import com.raywenderlich.android.creaturemon.util.schedulers.BaseSchedulerProvider
import io.reactivex.Observable
import io.reactivex.ObservableTransformer

class AddCreatureProcessorHolder(
    private val creatureRepository: CreatureRepository,
    private val creatureGenerator: CreatureGenerator,
    private val schedulerProvider: BaseSchedulerProvider
) {

  private val avatarProcessor =
      ObservableTransformer<AvatarAction, AvatarResult> { actions ->
        actions
            .map { action -> AvatarResult.Success(action.drawable) }
            .cast(AvatarResult::class.java)
            .onErrorReturn(AvatarResult::Failure)
            .subscribeOn(schedulerProvider.io())
            .observeOn(schedulerProvider.ui())
            .startWith(AvatarResult.Processing)
      }

  private val nameProcessor =
      ObservableTransformer<NameAction, NameResult> { actions ->
        actions
            .map { action -> NameResult.Success(action.name) }
            .cast(NameResult::class.java)
            .onErrorReturn(NameResult::Failure)
            .subscribeOn(schedulerProvider.io())
            .observeOn(schedulerProvider.ui())
            .startWith(NameResult.Processing)
      }

  private val intelligenceProcessor =
      ObservableTransformer<IntelligenceAction, IntelligenceResult> { actions ->
        actions
            .map { action ->
              IntelligenceResult.Success(
                  AttributeStore.INTELLIGENCE[action.intelligenceIndex].value)
            }
            .cast(IntelligenceResult::class.java)
            .onErrorReturn(IntelligenceResult::Failure)
            .subscribeOn(schedulerProvider.io())
            .observeOn(schedulerProvider.ui())
            .startWith(IntelligenceResult.Processing)
      }

  private val strengthProcessor =
      ObservableTransformer<StrengthAction, StrengthResult> { actions ->
        actions
            .map { action ->
              StrengthResult.Success(
                  AttributeStore.STRENGTH[action.strengthIndex].value)
            }
            .cast(StrengthResult::class.java)
            .onErrorReturn(StrengthResult::Failure)
            .subscribeOn(schedulerProvider.io())
            .observeOn(schedulerProvider.ui())
            .startWith(StrengthResult.Processing)
      }

  private val saveProcessor =
      ObservableTransformer<SaveAction, SaveResult> { actions ->
        actions.flatMap { action ->
          val attributes = CreatureAttributes(
              AttributeStore.INTELLIGENCE[action.intelligenceIndex].value,
              AttributeStore.STRENGTH[action.strengthIndex].value,
              AttributeStore.ENDURANCE[action.enduranceIndex].value)
          val creature = creatureGenerator.generateCreature(attributes, action.name, action.drawable)
          creatureRepository.saveCreature(creature)
              .map { SaveResult.Success }
              .cast(SaveResult::class.java)
              .onErrorReturn(SaveResult::Failure)
              .subscribeOn(schedulerProvider.io())
              .observeOn(schedulerProvider.ui())
              .startWith(SaveResult.Processing)
        }
      }

  internal var actionProcessor =
      ObservableTransformer<AddCreatureAction, AddCreatureResult> { actions ->
        actions.publish { shared ->
          Observable.merge(
              shared.ofType(AvatarAction::class.java).compose(avatarProcessor),
              shared.ofType(NameAction::class.java).compose(nameProcessor),
              shared.ofType(IntelligenceAction::class.java).compose(intelligenceProcessor),
              shared.ofType(StrengthAction::class.java).compose(strengthProcessor))
              .mergeWith(shared.ofType(SaveAction::class.java).compose(saveProcessor))
              .mergeWith(
                  // Error for not implemented actions
                  shared.filter { v ->
                    v !is AvatarAction
                        && v !is NameAction
                        && v !is IntelligenceAction
                        && v !is StrengthAction
                        && v !is SaveAction
                  }.flatMap { w ->
                    Observable.error<AddCreatureResult>(
                        IllegalArgumentException("Unknown Action type: $w"))
                  }
              )
        }
      }
}