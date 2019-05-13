package com.raywenderlich.android.creatures.presentation.browse

import android.arch.lifecycle.ViewModel
import android.arch.lifecycle.ViewModelProvider
import com.raywenderlich.android.creatures.domain.interactor.browse.GetCreatures
import com.raywenderlich.android.creatures.domain.interactor.browse.GetJupiterCreatures
import com.raywenderlich.android.creatures.presentation.mapper.CreatureMapper

open class BrowseCreaturesViewModelFactory(
    private val getCreatures: GetCreatures,
    private val getJupiter: GetJupiterCreatures,
    private val creatureMapper: CreatureMapper) : ViewModelProvider.Factory {

  override fun <T : ViewModel> create(modelClass: Class<T>): T {
    if (modelClass.isAssignableFrom(BrowseCreaturesViewModel::class.java)) {
      return BrowseCreaturesViewModel(getCreatures, getJupiter, creatureMapper) as T
    }
    throw IllegalArgumentException("Unknown ViewModel class")
  }
}
