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

import com.raywenderlich.android.creaturemon.mvibase.MviResult


sealed class AddCreatureResult : MviResult {
  sealed class AvatarResult : AddCreatureResult() {
    object Processing : AvatarResult()
    data class Success(val drawable: Int) : AvatarResult()
    data class Failure(val error: Throwable) : AvatarResult()
  }
  sealed class NameResult : AddCreatureResult() {
    object Processing : NameResult()
    data class Success(val name: String) : NameResult()
    data class Failure(val error: Throwable) : NameResult()
  }
  sealed class IntelligenceResult : AddCreatureResult() {
    object Processing : IntelligenceResult()
    data class Success(val intelligence: Int) : IntelligenceResult()
    data class Failure(val error: Throwable) : IntelligenceResult()
  }
  sealed class StrengthResult : AddCreatureResult() {
    object Processing : StrengthResult()
    data class Success(val strength: Int) : StrengthResult()
    data class Failure(val error: Throwable) : StrengthResult()
  }
  sealed class EnduranceResult : AddCreatureResult() {
    object Processing : EnduranceResult()
    data class Success(val endurance: Int) : EnduranceResult()
    data class Failure(val error: Throwable) : EnduranceResult()
  }
  sealed class SaveResult : AddCreatureResult() {
    object Processing : SaveResult()
    object Success : SaveResult()
    data class Failure(val error: Throwable) : SaveResult()
  }
}