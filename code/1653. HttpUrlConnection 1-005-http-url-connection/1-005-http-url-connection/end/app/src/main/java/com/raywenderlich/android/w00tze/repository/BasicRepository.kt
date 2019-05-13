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
import android.net.Uri
import android.os.AsyncTask
import android.util.Log
import com.raywenderlich.android.w00tze.app.Constants.fullUrlString
import com.raywenderlich.android.w00tze.model.Gist
import com.raywenderlich.android.w00tze.model.Repo
import com.raywenderlich.android.w00tze.model.User
import java.io.IOException


object BasicRepository : Repository {

  private const val TAG = "BasicRepository"

  private const val LOGIN = "w00tze"

  override fun getRepos(): LiveData<List<Repo>> {
    val liveData = MutableLiveData<List<Repo>>()

    FetchReposAsyncTask({ repos ->
      liveData.value = repos
    }).execute()

    return liveData
  }

  override fun getGists(): LiveData<List<Gist>> {
    val liveData = MutableLiveData<List<Gist>>()
    val gists = mutableListOf<Gist>()

    for (i in 0 until 100) {
      val gist = Gist("2018-02-23T17:42:52Z", "w00t")
      gists.add(gist)
    }

    liveData.value = gists

    return liveData
  }

  override fun getUser(): LiveData<User> {
    val liveData = MutableLiveData<User>()

    val user = User(
        1234L,
        "w00tze",
        "w00tze",
        "W00tzeWootze",
        "https://avatars0.githubusercontent.com/u/36771440?v=4")

    liveData.value = user

    return liveData
  }

  private fun fetchRepos(): List<Repo>? {
    try {
      val url = Uri.parse(fullUrlString("/users/${LOGIN}/repos")).toString()
      val jsonString = getUrlAsString(url)

      Log.i(TAG, "Repo data: $jsonString")

      val repos = mutableListOf<Repo>()

      for (i in 0 until 100) {
        val repo = Repo("repo name")
        repos.add(repo)
      }

      return repos
    } catch (e: IOException) {
      Log.e(TAG, "Error retrieving repos: ${e.localizedMessage}")
    }
    return null
  }

  private class FetchReposAsyncTask(val callback: ReposCallback) : AsyncTask<ReposCallback, Void, List<Repo>>() {
    override fun doInBackground(vararg params: ReposCallback?): List<Repo>? {
      return fetchRepos()
    }

    override fun onPostExecute(result: List<Repo>?) {
      super.onPostExecute(result)
      if (result != null) {
        callback(result)
      }
    }
  }
}