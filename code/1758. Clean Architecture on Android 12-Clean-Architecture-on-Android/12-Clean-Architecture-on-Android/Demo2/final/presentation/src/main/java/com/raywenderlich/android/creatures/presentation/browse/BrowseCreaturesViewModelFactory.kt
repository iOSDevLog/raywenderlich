package com.raywenderlich.android.creatures.presentation.browse

import android.arch.lifecycle.ViewModel
import android.arch.lifecycle.ViewModelProvider
import com.raywenderlich.android.creatures.domain.interactor.browse.GetCreatures
import com.raywenderlich.android.creatures.presentation.mapper.CreatureMapper

open class BrowseCreaturesViewModelFactory(
    private val getCreatures: GetCreatures,
    private val creatureMapper: CreatureMapper) : ViewModelProvider.Factory {

  override fun <T : ViewModel> create(modelClass: Class<T>): T {
    if (modelClass.isAssignableFrom(BrowseCreaturesViewModel::class.java)) {
      return BrowseCreaturesViewModel(getCreatures, creatureMapper) as T
    }
    throw IllegalArgumentException("Unknown ViewModel class")
  }
}
