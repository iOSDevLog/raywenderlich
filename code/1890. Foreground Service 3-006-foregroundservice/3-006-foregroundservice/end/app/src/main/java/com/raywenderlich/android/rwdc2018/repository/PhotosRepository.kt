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

package com.raywenderlich.android.rwdc2018.repository

import android.arch.lifecycle.LiveData
import android.arch.lifecycle.MutableLiveData
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.AsyncTask
import android.support.v4.content.LocalBroadcastManager
import androidx.work.*
import com.raywenderlich.android.rwdc2018.app.RWDC2018Application
import com.raywenderlich.android.rwdc2018.app.PhotosUtils
import com.raywenderlich.android.rwdc2018.service.DownloadWorker
import com.raywenderlich.android.rwdc2018.service.FetchIntentService
import java.util.concurrent.TimeUnit


class PhotosRepository : Repository {

  companion object {
    const val DOWNLOAD_WORK_TAG = "DOWNLOAD_WORK_TAG"
  }

  private val photosLiveData = MutableLiveData<List<String>>()
  private val bannerLiveData = MutableLiveData<String>()

  init {
    schedulePeriodicWorkRequest()
  }

  private val receiver = object : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
      FetchBannerAsyncTask({ banner ->
        bannerLiveData.value = banner
      }).execute()
      FetchPhotosAsyncTask({ photos ->
        photosLiveData.value = photos
      }).execute()
    }
  }

  override fun register() {
    LocalBroadcastManager.getInstance(RWDC2018Application.getAppContext())
        .registerReceiver(receiver, IntentFilter(FetchIntentService.FETCH_COMPLETE))
  }

  override fun unregister() {
    LocalBroadcastManager.getInstance(RWDC2018Application.getAppContext())
        .unregisterReceiver(receiver)
  }

  override fun getPhotos(): LiveData<List<String>> {
    FetchPhotosAsyncTask({ photos ->
      photosLiveData.value = photos
    }).execute()
    return photosLiveData
  }

  override fun getBanner(): LiveData<String> {
    FetchBannerAsyncTask({ banner ->
      bannerLiveData.value = banner
    }).execute()
    return bannerLiveData
  }

  private fun schedulePeriodicWorkRequest() {
    val constraints = Constraints.Builder()
        .setRequiredNetworkType(NetworkType.CONNECTED)
        .setRequiresStorageNotLow(true)
        .build()

    val workManager = WorkManager.getInstance()

    val request: WorkRequest = PeriodicWorkRequestBuilder<DownloadWorker>(15, TimeUnit.MINUTES)
        .setConstraints(constraints)
        .addTag(DOWNLOAD_WORK_TAG)
        .build()

    workManager.cancelAllWorkByTag(DOWNLOAD_WORK_TAG)
    workManager.enqueue(request)
  }

  private class FetchBannerAsyncTask(val callback: (String) -> Unit)
    : AsyncTask<Void, Void, String>() {
    override fun doInBackground(vararg params: Void): String? {
      val photosString = PhotosUtils.photoJsonString()
      return PhotosUtils.bannerFromJsonString(photosString ?: "")
    }

    override fun onPostExecute(result: String?) {
      if (result != null) {
        callback(result)
      }
    }
  }

  private class FetchPhotosAsyncTask(val callback: (List<String>) -> Unit)
    : AsyncTask<Void, Void, List<String>>() {
    override fun doInBackground(vararg params: Void): List<String>? {
      val photosString = PhotosUtils.photoJsonString()
      return PhotosUtils.photoUrlsFromJsonString(photosString ?: "")
    }

    override fun onPostExecute(result: List<String>?) {
      if (result != null) {
        callback(result)
      }
    }
  }
}