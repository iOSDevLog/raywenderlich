package com.raywenderlich.android.rwdc2018.service

import android.app.Service
import android.content.Intent
import android.media.MediaPlayer
import android.net.Uri
import android.os.IBinder
import com.raywenderlich.android.rwdc2018.app.SongUtils
import com.raywenderlich.android.rwdc2018.app.RWDC2018Application

class SongService : Service() {

  private lateinit var player: MediaPlayer

  override fun onBind(intent: Intent): IBinder? {
    return null // Prevents binding with Activity
  }

  override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
    player = MediaPlayer.create(this, Uri.fromFile(SongUtils.songFile()))
    player.isLooping = true
    player.start()
    RWDC2018Application.isPlayingSong = true
    return START_STICKY
  }

  override fun onDestroy() {
    player.stop()
    RWDC2018Application.isPlayingSong = false
    super.onDestroy()
  }
}
