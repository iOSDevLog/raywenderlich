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
import com.raywenderlich.android.w00tze.app.isNullOrBlankOrNullString
import com.raywenderlich.android.w00tze.model.Gist
import com.raywenderlich.android.w00tze.model.Repo
import com.raywenderlich.android.w00tze.model.User
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject
import java.io.IOException


object RemoteRepository : Repository {

  private const val TAG = "RemoteRepository"

  private const val LOGIN = "w00tze"

  override fun getRepos(): LiveData<List<Repo>> {
    val liveData = MutableLiveData<List<Repo>>()

    FetchAsyncTask("/users/$LOGIN/repos", ::parseRepos, { repos ->
      liveData.value = repos
    }).execute()

    return liveData
  }

  override fun getGists(): LiveData<List<Gist>> {
    val liveData = MutableLiveData<List<Gist>>()

    FetchAsyncTask("/users/$LOGIN/gists", ::parseGists, { gists ->
      liveData.value = gists
    }).execute()

    return liveData
  }

  override fun getUser(): LiveData<User> {
    val liveData = MutableLiveData<User>()

    FetchAsyncTask("/users/$LOGIN", ::parseUser, { user ->
      liveData.value = user
    }).execute()

    return liveData
  }

  private fun <T> fetch(path: String, parser: (String) -> T): T? {
    try {
      val url = Uri.parse(fullUrlString(path)).toString()
      val jsonString = getUrlAsString(url)

      return parser(jsonString)
    } catch (e: IOException) {
      Log.e(TAG, "Error retrieving path: $path ::: ${e.localizedMessage}")
    } catch (e: JSONException) {
      Log.e(TAG, "Error retrieving path: $path ::: ${e.localizedMessage}")
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

  private fun parseUser(jsonString: String): User {
    val userObject = JSONObject(jsonString)

    val id = userObject.getLong("id")
    val name = if (userObject.getString("name").isNullOrBlankOrNullString()) "" else userObject.getString("name")
    val login = userObject.getString("login")
    val company = if (userObject.getString("company").isNullOrBlankOrNullString()) "" else userObject.getString("company")
    val avatarUrl = userObject.getString("avatar_url")

    return User(
        id,
        name,
        login,
        company,
        avatarUrl)
  }

  private class FetchAsyncTask<T>(val path: String, val parser: (String) -> T, val callback: (T) -> Unit) : AsyncTask<(T) -> Unit, Void, T>() {
    override fun doInBackground(vararg params: ((T) -> Unit)?): T? {
      return fetch(path, parser)
    }

    override fun onPostExecute(result: T) {
      super.onPostExecute(result)
      if (result != null) {
        callback(result)
      }
    }
  }
}