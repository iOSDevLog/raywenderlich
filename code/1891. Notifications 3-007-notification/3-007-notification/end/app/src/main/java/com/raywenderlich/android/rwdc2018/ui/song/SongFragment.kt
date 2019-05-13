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

package com.raywenderlich.android.rwdc2018.ui.song

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import android.support.v4.app.Fragment
import android.support.v4.content.ContextCompat
import android.support.v4.content.LocalBroadcastManager
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.raywenderlich.android.rwdc2018.R
import com.raywenderlich.android.rwdc2018.app.Constants
import com.raywenderlich.android.rwdc2018.app.RWDC2018Application
import com.raywenderlich.android.rwdc2018.app.SongUtils
import com.raywenderlich.android.rwdc2018.service.DownloadIntentService
import com.raywenderlich.android.rwdc2018.service.SongService
import kotlinx.android.synthetic.main.fragment_song.*

class SongFragment : Fragment() {

  companion object {
    fun newInstance(): SongFragment {
      return SongFragment()
    }
  }

  private val receiver = object : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
      val param = intent?.getStringExtra(DownloadIntentService.DOWNLOAD_COMPLETE_KEY)
      Log.i("SongFragment", "Received broadcast for $param")
      if (SongUtils.songFile().exists()) {
        enablePlayButton()
      }
    }
  }

  override fun onStart() {
    super.onStart()
    LocalBroadcastManager.getInstance(RWDC2018Application.getAppContext())
        .registerReceiver(receiver, IntentFilter(DownloadIntentService.DOWNLOAD_COMPLETE))
  }

  override fun onStop() {
    super.onStop()
    LocalBroadcastManager.getInstance(RWDC2018Application.getAppContext())
        .unregisterReceiver(receiver)
  }

  override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
    return inflater.inflate(R.layout.fragment_song, container, false)
  }

  override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
    super.onViewCreated(view, savedInstanceState)

    downloadButton.setOnClickListener {
      DownloadIntentService.startActionDownload(view.context, Constants.SONG_URL)
      disableMediaButtons()
      stopPlaying()
    }

    playButton.setOnClickListener {
      val ctx = context
      if (ctx != null) {
        ContextCompat.startForegroundService(ctx, Intent(ctx, SongService::class.java))
      }
      enableStopButton()
    }

    stopButton.setOnClickListener {
      stopPlaying()
    }
  }

  private fun stopPlaying() {
    activity?.stopService(Intent(context, SongService::class.java))
    enablePlayButton()
  }

  override fun onResume() {
    super.onResume()

    if (RWDC2018Application.isPlayingSong) {
      enableStopButton()
    } else {
      enablePlayButton()
    }

    if (!SongUtils.songFile().exists()) {
      disableMediaButtons()
    }
  }

  private fun enablePlayButton() {
    playButton.isEnabled = true
    stopButton.isEnabled = false
  }

  private fun enableStopButton() {
    playButton.isEnabled = false
    stopButton.isEnabled = true
  }

  private fun disableMediaButtons() {
    playButton.isEnabled = false
    stopButton.isEnabled = false
  }
}