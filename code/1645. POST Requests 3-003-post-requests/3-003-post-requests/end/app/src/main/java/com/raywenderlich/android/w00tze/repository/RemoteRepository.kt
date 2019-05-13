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
import com.raywenderlich.android.w00tze.model.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response


object RemoteRepository : Repository {

  private val LOGIN = AuthenticationPrefs.getUsername()

  private val api = Injection.provideGitHubApi()

  override fun getRepos(): LiveData<Either<List<Repo>>> {
    val liveData = MutableLiveData<Either<List<Repo>>>()

    api.getRepos(LOGIN).enqueue(object : Callback<List<Repo>> {
      override fun onResponse(call: Call<List<Repo>>?, response: Response<List<Repo>>?) {
        if (response != null && response.isSuccessful) {
          liveData.value = Either.success(response.body())
        } else {
          liveData.value = Either.error(ApiError.REPOS, null)
        }
      }

      override fun onFailure(call: Call<List<Repo>>?, t: Throwable?) {
        liveData.value = Either.error(ApiError.REPOS, null)
      }
    })

    return liveData
  }

  override fun getGists(): LiveData<Either<List<Gist>>> {
    val liveData = MutableLiveData<Either<List<Gist>>>()

    api.getGists(LOGIN).enqueue(object : Callback<List<Gist>> {
      override fun onResponse(call: Call<List<Gist>>?, response: Response<List<Gist>>?) {
        if (response != null && response.isSuccessful) {
          liveData.value = Either.success(response.body())
        } else {
          liveData.value = Either.error(ApiError.GISTS, null)
        }
      }

      override fun onFailure(call: Call<List<Gist>>?, t: Throwable?) {
        liveData.value = Either.error(ApiError.GISTS, null)
      }
    })

    return liveData
  }

  override fun getUser(): LiveData<Either<User>> {
    val liveData = MutableLiveData<Either<User>>()

    api.getUser(LOGIN).enqueue(object : Callback<User> {
      override fun onResponse(call: Call<User>?, response: Response<User>?) {
        if (response != null && response.isSuccessful) {
          liveData.value = Either.success(response.body())
        } else {
          liveData.value = Either.error(ApiError.USER, null)
        }
      }

      override fun onFailure(call: Call<User>?, t: Throwable?) {
        liveData.value = Either.error(ApiError.USER, null)
      }
    })

    return liveData
  }

  override fun postGist(request: GistRequest): LiveData<Either<Gist>> {
    val liveData = MutableLiveData<Either<Gist>>()

    api.postGist(request).enqueue(object : Callback<Gist> {
      override fun onResponse(call: Call<Gist>?, response: Response<Gist>?) {
        if (response != null && response.isSuccessful) {
          liveData.value = Either.success(response.body())
        } else {
          liveData.value = Either.error(ApiError.POST_GIST, null)
        }
      }

      override fun onFailure(call: Call<Gist>?, t: Throwable?) {
        liveData.value = Either.error(ApiError.POST_GIST, null)
      }
    })

    return liveData
  }
}