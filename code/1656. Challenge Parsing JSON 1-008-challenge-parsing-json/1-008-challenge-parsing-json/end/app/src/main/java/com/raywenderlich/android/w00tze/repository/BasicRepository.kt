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
import org.json.JSONArray
import org.json.JSONException
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

    FetchGistsAsyncTask({ gists ->
      liveData.value = gists
    }).execute()

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
      
      return parseRepos(jsonString)
    } catch (e: IOException) {
      Log.e(TAG, "Error retrieving repos: ${e.localizedMessage}")
    } catch (e: JSONException) {
      Log.e(TAG, "Error retrieving repos: ${e.localizedMessage}")
    }
    return null
  }

  private fun parseRepos(jsonString: String): List<Repo> {
    val repos = mutableListOf<Repo>()

    val reposArray = JSONArray(jsonString)
    for (i in 0 until reposArray.length()) {
      val repoObject = reposArray.getJSONObject(i)
      val repo = Repo(repoObject.getString("name"))
      repos.add(repo)
    }

    return repos
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

  private fun fetchGists(): List<Gist>? {
    try {
      val url = Uri.parse(fullUrlString("/users/$LOGIN/gists")).toString()
      val jsonString = getUrlAsString(url)

      return parseGists(jsonString)
    } catch (e: IOException) {
      Log.e(TAG, "Error retrieving gists: ${e.localizedMessage}")
    } catch (e: JSONException) {
      Log.e(TAG, "Error retrieving gists: ${e.localizedMessage}")
    }
    return null
  }

  private fun parseGists(jsonString: String): List<Gist> {
    val gists = mutableListOf<Gist>()

    val gistsArray = JSONArray(jsonString)
    for (i in 0 until gistsArray.length()) {
      val gistObject = gistsArray.getJSONObject(i)
      val createdAt = gistObject.getString("created_at")
      val description = gistObject.getString("description")
      val gist = Gist(createdAt, description)
      gists.add(gist)
    }

    return gists
  }

  private class FetchGistsAsyncTask(val callback: GistsCallback) : AsyncTask<GistsCallback, Void, List<Gist>>() {
    override fun doInBackground(vararg params: GistsCallback?): List<Gist>? {
      return fetchGists()
    }

    override fun onPostExecute(result: List<Gist>?) {
      super.onPostExecute(result)
      if (result != null) {
        callback(result)
      }
    }
  }
}