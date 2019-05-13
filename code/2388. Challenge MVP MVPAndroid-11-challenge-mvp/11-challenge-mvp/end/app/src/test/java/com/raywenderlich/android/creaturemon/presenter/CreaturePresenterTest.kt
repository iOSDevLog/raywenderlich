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

package com.raywenderlich.android.creaturemon.presenter

import com.raywenderlich.android.creaturemon.model.*
import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.Mockito.*
import org.mockito.MockitoAnnotations

class CreaturePresenterTest {

  private lateinit var presenter: CreaturePresenter

  @Mock
  lateinit var view: CreatureContract.View

  @Mock
  lateinit var mockGenerator: CreatureGenerator

  @Mock
  lateinit var mockRepository: CreatureRepository

  @Before
  fun setup() {
    MockitoAnnotations.initMocks(this)
    presenter = CreaturePresenter(mockGenerator, mockRepository)
    presenter.setView(view)
  }

  @Test
  fun testIntelligenceSelected() {
    val attributes = CreatureAttributes(10, 0, 0)
    val stubCreature = Creature(attributes, 50)
    `when`(mockGenerator.generateCreature(attributes)).thenReturn(stubCreature)

    presenter.attributeSelected(AttributeType.INTELLIGENCE, 3)

    verify(view, times(1)).showHitPoints("50")
  }

  @Test
  fun testStrengthSelected() {
    val attributes = CreatureAttributes(0, 3, 0)
    val stubCreature = Creature(attributes, 9)
    `when`(mockGenerator.generateCreature(attributes)).thenReturn(stubCreature)

    presenter.attributeSelected(AttributeType.STRENGTH, 1)

    verify(view, times(1)).showHitPoints("9")
  }

  @Test
  fun testEnduranceSelected() {
    val attributes = CreatureAttributes(0, 0, 7)
    val stubCreature = Creature(attributes, 28)
    `when`(mockGenerator.generateCreature(attributes)).thenReturn(stubCreature)

    presenter.attributeSelected(AttributeType.ENDURANCE, 2)

    verify(view, times(1)).showHitPoints("28")
  }
}