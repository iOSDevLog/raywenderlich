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

package com.raywenderlich.android.w00tze.model

import android.preference.PreferenceManager
import com.raywenderlich.android.w00tze.app.W00tzeApplication


object AuthenticationPrefs {

  private const val KEY_AUTH_TOKEN = "KEY_AUTH_TOKEN"

  private const val KEY_TOKEN_TYPE = "KEY_TOKEN_TYPE"

  private const val KEY_USERNAME = "KEY_USERNAME"

  private fun sharedPrefs() = PreferenceManager.getDefaultSharedPreferences(W00tzeApplication.getAppContext())

  fun saveAuthToken(token: String) {
    val editor = sharedPrefs().edit()
    editor.putString(KEY_AUTH_TOKEN, token).apply()
  }

  fun getAuthToken(): String = sharedPrefs().getString(KEY_AUTH_TOKEN, "")

  fun isAuthenticated() = !getAuthToken().isBlank()

  fun saveTokenType(tokenType: String) {
    val editor = sharedPrefs().edit()
    editor.putString(KEY_TOKEN_TYPE, tokenType).apply()
  }

  fun getTokenType(): String = sharedPrefs().getString(KEY_TOKEN_TYPE, "")

  fun saveUsername(username: String) {
    val editor = sharedPrefs().edit()
    editor.putString(KEY_USERNAME, username).apply()
  }

  fun getUsername(): String = sharedPrefs().getString(KEY_USERNAME, "w00tze")

  fun clearUsername() = sharedPrefs().edit().remove(KEY_USERNAME).apply()
}