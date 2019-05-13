package com.raywenderlich.android.creatures.ui.injection.module

import com.raywenderlich.android.creatures.ui.browse.MainActivity
import com.raywenderlich.android.creatures.ui.injection.scopes.PerActivity
import dagger.Module
import dagger.android.ContributesAndroidInjector


@Module
abstract class ActivityBindingModule {

  @PerActivity
  @ContributesAndroidInjector(modules = arrayOf(BrowseActivityModule::class))
  abstract fun bindMainActivity(): MainActivity

}