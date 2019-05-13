package com.raywenderlich.android.creatures.ui.injection.component

import com.raywenderlich.android.creatures.ui.browse.MainActivity
import dagger.Subcomponent
import dagger.android.AndroidInjector


@Subcomponent
interface BrowseActivitySubComponent : AndroidInjector<MainActivity> {

  @Subcomponent.Builder
  abstract class Builder : AndroidInjector.Builder<MainActivity>()

}