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

package com.raywenderlich.android.gitfeed

import android.arch.lifecycle.MutableLiveData
import android.arch.lifecycle.ViewModel
import io.reactivex.Observable
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.schedulers.Schedulers

class MainViewModel : ViewModel() {

  val eventLiveData = MutableLiveData<List<Event>>()

  private var lastModified: String? = null

  var events = mutableListOf<Event>()

  private val gitHubApi by lazy {
    GitHubApi.create()
  }

  private val disposables = CompositeDisposable()

  fun fetchEvents(repo: String) {
    eventLiveData.value = EventsStore.readEvents()

    lastModified = EventsStore.readLastModified()

    val apiResponse = gitHubApi.fetchEvents(repo, lastModified?.trim() ?: "").share()

    val eventsSubscription = apiResponse
        .filter { response ->
          (200..300).contains(response.code())
        }
        .map { response ->
          response.body()
        }
        .filter { objects ->
          objects.isNotEmpty()
        }
        .map { objects ->
          objects.mapNotNull { Event.fromAnyDict(it) }
        }
        .subscribeOn(Schedulers.io())
        .observeOn(AndroidSchedulers.mainThread())
        .subscribe(
            { events -> processEvents(events) },
            { error -> println("Events Error ::: ${error.message}") }
        )
    disposables.add(eventsSubscription)

    val lastModifiedSubscription = apiResponse
        .filter { response ->
          (200 until 400).contains(response.code())
        }
        .flatMap { response ->
          val value = response.headers().get("Last-Modified")
          if (value == null) {
            Observable.empty()
          } else {
            Observable.just(value)
          }
        }
        .subscribeOn(Schedulers.io())
        .observeOn(AndroidSchedulers.mainThread())
        .subscribe(
            { EventsStore.saveLastModified(it) },
            { error -> println("Last Modified Error ::: ${error.message}") }
        )
    disposables.add(lastModifiedSubscription)
  }

  override fun onCleared() {
    super.onCleared()
    disposables.dispose()
  }

  private fun processEvents(newEvents: List<Event>) {
    var updatedEvents = newEvents + events

    if (updatedEvents.size > 50) {
      updatedEvents = updatedEvents.slice(0 until 50)
    }

    events = updatedEvents.toMutableList()

    eventLiveData.value = events

    EventsStore.saveEvents(events)
  }
}