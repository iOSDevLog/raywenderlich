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

package com.raywenderlich.android.w00tze.repository

import android.arch.lifecycle.LiveData
import android.arch.lifecycle.MutableLiveData
import com.raywenderlich.android.w00tze.app.Injection
import com.raywenderlich.android.w00tze.model.Gist
import com.raywenderlich.android.w00tze.model.Repo
import com.raywenderlich.android.w00tze.model.User
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response


object RemoteRepository : Repository {

  private const val TAG = "BasicRepository"

  private const val LOGIN = "w00tze"

  private val api = Injection.provideGitHubApi()

  override fun getRepos(): LiveData<List<Repo>> {
    val liveData = MutableLiveData<List<Repo>>()

    api.getRepos(LOGIN).enqueue(object : Callback<List<Repo>> {
      override fun onResponse(call: Call<List<Repo>>?, response: Response<List<Repo>>?) {
        if (response != null) {
          liveData.value = response.body()
        }
      }
      override fun onFailure(call: Call<List<Repo>>?, t: Throwable?) {
      }
    })

    return liveData
  }

  override fun getGists(): LiveData<List<Gist>> {
    val liveData = MutableLiveData<List<Gist>>()

    api.getGists(LOGIN).enqueue(object : Callback<List<Gist>> {
      override fun onResponse(call: Call<List<Gist>>?, response: Response<List<Gist>>?) {
        if (response != null) {
          liveData.value = response.body()
        }
      }
      override fun onFailure(call: Call<List<Gist>>?, t: Throwable?) {
      }
    })

    return liveData
  }

  override fun getUser(): LiveData<User> {
    val liveData = MutableLiveData<User>()

    api.getUser(LOGIN).enqueue(object : Callback<User> {
      override fun onResponse(call: Call<User>?, response: Response<User>?) {
        if (response != null) {
          liveData.value = response.body()
        }
      }
      override fun onFailure(call: Call<User>?, t: Throwable?) {
      }
    })

    return liveData
  }
}