package com.raywenderlich.android.creatures.domain.interactor.browse

import com.raywenderlich.android.creatures.domain.executor.PostExecutionThread
import com.raywenderlich.android.creatures.domain.executor.ThreadExecutor
import com.raywenderlich.android.creatures.domain.interactor.FlowableUseCase
import com.raywenderlich.android.creatures.domain.model.Creature
import com.raywenderlich.android.creatures.domain.repository.CreatureRepository
import io.reactivex.Flowable
import javax.inject.Inject


/**
 * Use case used for retrieving a [List] of [Creature] instances from Jupiter from the [CreatureRepository]
 */
open class GetJupiterCreatures @Inject constructor(private val creatureRepository: CreatureRepository,
                                            threadExecutor: ThreadExecutor,
                                            postExecutionThread: PostExecutionThread):
    FlowableUseCase<List<Creature>, Void?>(threadExecutor, postExecutionThread) {

  public override fun buildUseCaseObservable(params: Void?): Flowable<List<Creature>> =
      creatureRepository.getJupiterCreatures()
}