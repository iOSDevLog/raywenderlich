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

package com.raywenderlich.android.w00tze.viewmodel

import android.app.Application
import android.arch.lifecycle.AndroidViewModel
import android.net.Uri
import com.raywenderlich.android.w00tze.BuildConfig
import com.raywenderlich.android.w00tze.app.Injection
import com.raywenderlich.android.w00tze.model.AccessToken
import com.raywenderlich.android.w00tze.model.AuthenticationPrefs
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response


class MainViewModel(application: Application) : AndroidViewModel(application) {

  private val authApi = Injection.provideAuthApi()

  fun isAuthenticated() = AuthenticationPrefs.isAuthenticated()

  fun getAccessToken(uri: Uri, callback: () -> Unit) {
    val accessCode = uri.getQueryParameter("code")

    authApi.getAccessToken(BuildConfig.CLIENT_ID, BuildConfig.CLIENT_SECRET, accessCode).enqueue(object : Callback<AccessToken> {
      override fun onResponse(call: Call<AccessToken>?, response: Response<AccessToken>?) {
        val accessToken = response?.body()?.accessToken
        val tokenType = response?.body()?.tokenType
        if (accessToken != null && tokenType != null) {
          AuthenticationPrefs.saveAuthToken(accessToken)
          AuthenticationPrefs.saveTokenType(tokenType)
          callback()
        }
      }

      override fun onFailure(call: Call<AccessToken>?, t: Throwable?) {
        println("ERROR GETTING TOKEN")
      }
    })
  }

  fun logout() {
    AuthenticationPrefs.saveAuthToken("")
    AuthenticationPrefs.clearUsername()
  }
}