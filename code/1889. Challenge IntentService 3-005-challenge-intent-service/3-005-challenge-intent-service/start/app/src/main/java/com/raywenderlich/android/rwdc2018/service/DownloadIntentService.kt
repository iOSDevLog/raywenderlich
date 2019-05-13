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

package com.raywenderlich.android.rwdc2018.service

import android.app.IntentService
import android.content.Context
import android.content.Intent
import android.support.v4.content.LocalBroadcastManager
import android.util.Log
import com.raywenderlich.android.rwdc2018.app.Constants
import com.raywenderlich.android.rwdc2018.app.SongUtils


class DownloadIntentService : IntentService("DownloadIntentService") {

  companion object {

    private const val TAG: String = "DownloadIntentService"

    private const val ACTION_DOWNLOAD = "ACTION_DOWNLOAD"

    private const val EXTRA_URL = "EXTRA_URL"

    const val DOWNLOAD_COMPLETE = "DOWNLOAD_COMPLETE"

    const val DOWNLOAD_COMPLETE_KEY = "DOWNLOAD_COMPLETE_KEY"

    fun startActionDownload(context: Context, param: String) {
      val intent = Intent(context, DownloadIntentService::class.java).apply {
        action = ACTION_DOWNLOAD
        putExtra(EXTRA_URL, param)
      }
      context.startService(intent)
    }
  }

  override fun onCreate() {
    super.onCreate()
    Log.i(TAG, "Creating Service")
  }

  override fun onDestroy() {
    Log.i(TAG, "Destroying Service")
    super.onDestroy()
  }

  override fun onHandleIntent(intent: Intent?) {
    when (intent?.action) {
      ACTION_DOWNLOAD -> {
        handleActionDownload(intent.getStringExtra(EXTRA_URL))
      }
    }
  }

  private fun handleActionDownload(param: String) {
    Log.i(TAG, "Starting download for $param")
    SongUtils.download(param)
    Log.i(TAG, "Ending download for $param")

    Log.i(TAG, "Sending broadcast for $param")
    broadcastDownloadComplete(param)
  }

  private fun broadcastDownloadComplete(param: String) {
    val intent = Intent(DOWNLOAD_COMPLETE)
    intent.putExtra(DOWNLOAD_COMPLETE_KEY, param)
    LocalBroadcastManager.getInstance(applicationContext).sendBroadcast(intent)
  }
}
