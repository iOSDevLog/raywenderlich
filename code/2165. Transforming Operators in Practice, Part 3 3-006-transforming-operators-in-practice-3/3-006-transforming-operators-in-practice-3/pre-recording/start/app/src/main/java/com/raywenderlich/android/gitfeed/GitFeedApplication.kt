package com.raywenderlich.android.gitfeed

import android.app.Application
import android.content.Context

class GitFeedApplication : Application() {

  companion object {
    private lateinit var instance: GitFeedApplication

    fun getAppContext(): Context = instance.applicationContext
  }

  override fun onCreate() {
    instance = this
    super.onCreate()
  }
}