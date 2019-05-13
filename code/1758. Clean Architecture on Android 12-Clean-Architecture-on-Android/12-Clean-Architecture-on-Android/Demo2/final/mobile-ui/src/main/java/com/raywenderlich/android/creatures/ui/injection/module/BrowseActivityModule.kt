package com.raywenderlich.android.creatures.ui.injection.module

import com.raywenderlich.android.creatures.domain.interactor.browse.GetCreatures
import com.raywenderlich.android.creatures.presentation.browse.BrowseCreaturesViewModelFactory
import com.raywenderlich.android.creatures.presentation.mapper.CreatureMapper
import dagger.Module
import dagger.Provides


/**
 * Module used to provide dependencies at an activity-level.
 */
@Module
open class BrowseActivityModule {

  @Provides
  fun provideBrowseCreaturesViewModelFactory(getCreatures: GetCreatures,
                                             creatureMapper: CreatureMapper):
      BrowseCreaturesViewModelFactory {
    return BrowseCreaturesViewModelFactory(getCreatures, creatureMapper)
  }

}