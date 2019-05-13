package com.raywenderlich.android.creatures.ui.injection.module

import android.app.Application
import android.content.Context
import com.nhaarman.mockito_kotlin.mock
import com.raywenderlich.android.creatures.cache.PreferencesHelper
import com.raywenderlich.android.creatures.data.executor.JobExecutor
import com.raywenderlich.android.creatures.data.repository.CreatureCache
import com.raywenderlich.android.creatures.data.repository.CreatureRemote
import com.raywenderlich.android.creatures.domain.executor.PostExecutionThread
import com.raywenderlich.android.creatures.domain.executor.ThreadExecutor
import com.raywenderlich.android.creatures.domain.repository.CreatureRepository
import com.raywenderlich.android.creatures.remote.CreatureService
import com.raywenderlich.android.creatures.ui.UiThread
import com.raywenderlich.android.creatures.ui.injection.scopes.PerApplication
import dagger.Module
import dagger.Provides


@Module
class TestApplicationModule {

  @Provides
  @PerApplication
  fun provideContext(application: Application): Context {
    return application
  }

  @Provides
  @PerApplication
  internal fun providePreferencesHelper(): PreferencesHelper {
    return mock()
  }

  @Provides
  @PerApplication
  internal fun provideCreatureRepository(): CreatureRepository {
    return mock()
  }

  @Provides
  @PerApplication
  internal fun provideCreatureCache(): CreatureCache {
    return mock()
  }

  @Provides
  @PerApplication
  internal fun provideCreatureRemote(): CreatureRemote {
    return mock()
  }

  @Provides
  @PerApplication
  internal fun provideThreadExecutor(jobExecutor: JobExecutor): ThreadExecutor {
    return jobExecutor
  }

  @Provides
  @PerApplication
  internal fun providePostExecutionThread(uiThread: UiThread): PostExecutionThread {
    return uiThread
  }

  @Provides
  @PerApplication
  internal fun provideCreatureService(): CreatureService {
    return mock()
  }
}