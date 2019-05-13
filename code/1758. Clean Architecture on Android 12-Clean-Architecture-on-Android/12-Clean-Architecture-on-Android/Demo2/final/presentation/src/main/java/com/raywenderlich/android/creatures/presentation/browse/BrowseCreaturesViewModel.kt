package com.raywenderlich.android.creatures.presentation.browse

import android.arch.lifecycle.LiveData
import android.arch.lifecycle.MutableLiveData
import android.arch.lifecycle.ViewModel
import com.raywenderlich.android.creatures.domain.interactor.browse.GetCreatures
import com.raywenderlich.android.creatures.domain.model.Creature
import com.raywenderlich.android.creatures.presentation.data.Resource
import com.raywenderlich.android.creatures.presentation.data.ResourceState
import com.raywenderlich.android.creatures.presentation.mapper.CreatureMapper
import com.raywenderlich.android.creatures.presentation.model.CreatureView
import io.reactivex.subscribers.DisposableSubscriber
import javax.inject.Inject


open class BrowseCreaturesViewModel @Inject internal constructor(
    private val getCreatures: GetCreatures,
    private val creatureMapper: CreatureMapper) : ViewModel() {

  private val creaturesLiveData: MutableLiveData<Resource<List<CreatureView>>> = MutableLiveData()

  init {
    fetchCreatures()
  }

  override fun onCleared() {
    getCreatures.dispose()
    super.onCleared()
  }

  fun getCreatures(): LiveData<Resource<List<CreatureView>>> {
    return creaturesLiveData
  }

  fun fetchCreatures() {
    creaturesLiveData.postValue(Resource(ResourceState.LOADING, null, null))
    return getCreatures.execute(CreatureSubscriber())
  }

  inner class CreatureSubscriber: DisposableSubscriber<List<Creature>>() {

    override fun onComplete() { }

    override fun onNext(t: List<Creature>) {
      creaturesLiveData.postValue(Resource(ResourceState.SUCCESS,
          t.map { creatureMapper.mapToView(it) }, null))
    }

    override fun onError(exception: Throwable) {
      creaturesLiveData.postValue(Resource(ResourceState.ERROR, null, exception.message))
    }
  }
}