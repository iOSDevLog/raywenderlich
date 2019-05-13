package com.raywenderlich.android.creatures.ui.injection.module

import android.app.Application
import android.arch.lifecycle.ViewModelProvider
import android.arch.persistence.room.Room
import android.content.Context
import com.raywenderlich.android.creatures.cache.CreatureCacheImpl
import com.raywenderlich.android.creatures.cache.PreferencesHelper
import com.raywenderlich.android.creatures.cache.db.CreaturesDatabase
import com.raywenderlich.android.creatures.cache.mapper.CreatureEntityMapper
import com.raywenderlich.android.creatures.data.CreatureDataRepository
import com.raywenderlich.android.creatures.data.executor.JobExecutor
import com.raywenderlich.android.creatures.data.mapper.CreatureMapper
import com.raywenderlich.android.creatures.data.repository.CreatureCache
import com.raywenderlich.android.creatures.data.repository.CreatureRemote
import com.raywenderlich.android.creatures.data.source.CreatureDataStoreFactory
import com.raywenderlich.android.creatures.domain.executor.PostExecutionThread
import com.raywenderlich.android.creatures.domain.executor.ThreadExecutor
import com.raywenderlich.android.creatures.domain.repository.CreatureRepository
import com.raywenderlich.android.creatures.remote.CreatureRemoteImpl
import com.raywenderlich.android.creatures.remote.CreatureService
import com.raywenderlich.android.creatures.remote.CreatureServiceFactory
import com.raywenderlich.android.creatures.ui.BuildConfig
import com.raywenderlich.android.creatures.ui.UiThread
import com.raywenderlich.android.creatures.ui.injection.scopes.PerApplication
import dagger.Module
import dagger.Provides


/**
 * Module used to provide dependencies at an application-level.
 */
@Module
open class ApplicationModule {

  @Provides
  @PerApplication
  fun provideContext(application: Application): Context {
    return application
  }

  @Provides
  @PerApplication
  internal fun providePreferencesHelper(context: Context): PreferencesHelper {
    return PreferencesHelper(context)
  }


  @Provides
  @PerApplication
  internal fun provideCreatureRepository(factory: CreatureDataStoreFactory,
                                         mapper: CreatureMapper): CreatureRepository {
    return CreatureDataRepository(factory, mapper)
  }

  @Provides
  @PerApplication
  internal fun provideCreatureCache(database: CreaturesDatabase,
                                    entityMapper: CreatureEntityMapper,
                                    helper: PreferencesHelper): CreatureCache {
    return CreatureCacheImpl(database, entityMapper, helper)
  }

  @Provides
  @PerApplication
  internal fun provideCreatureRemote(service: CreatureService,
                                     factory: com.raywenderlich.android.creatures.remote.mapper.CreatureEntityMapper): CreatureRemote {
    return CreatureRemoteImpl(service, factory)
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
    return CreatureServiceFactory.makeCreatureService(BuildConfig.DEBUG)
  }

  @Provides
  @PerApplication
  internal fun provideViewModelFactory(): ViewModelProvider.Factory {
    return ViewModelProvider.NewInstanceFactory()
  }

  @Provides
  @PerApplication
  internal fun provideCreaturesDatabase(application: Application): CreaturesDatabase {
    return Room.databaseBuilder(application.applicationContext,
        CreaturesDatabase::class.java, "creatures.db")
        .build()
  }
}
