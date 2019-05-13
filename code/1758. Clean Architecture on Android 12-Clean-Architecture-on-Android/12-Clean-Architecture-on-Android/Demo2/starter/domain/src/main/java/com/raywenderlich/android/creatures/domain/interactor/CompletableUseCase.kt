package com.raywenderlich.android.creatures.domain.interactor

import com.raywenderlich.android.creatures.domain.executor.PostExecutionThread
import com.raywenderlich.android.creatures.domain.executor.ThreadExecutor
import io.reactivex.Completable
import io.reactivex.disposables.Disposable
import io.reactivex.disposables.Disposables
import io.reactivex.schedulers.Schedulers


/**
 * Abstract class for a UseCase that returns an instance of a [Completable].
 */
// TODO: remove if not used
abstract class CompletableUseCase<in Params> protected constructor(
    private val threadExecutor: ThreadExecutor,
    private val postExecutionThread: PostExecutionThread) {

  private val subscription = Disposables.empty()

  /**
   * Builds a [Completable] which will be used when the current [CompletableUseCase] is executed.
   */
  protected abstract fun buildUseCaseObservable(params: Params): Completable

  /**
   * Executes the current use case.
   */
  fun execute(params: Params): Completable {
    return this.buildUseCaseObservable(params)
        .subscribeOn(Schedulers.from(threadExecutor))
        .observeOn(postExecutionThread.scheduler)
  }

  /**
   * Unsubscribes from current [Disposable].
   */
  fun unsubscribe() {
    if (!subscription.isDisposed) {
      subscription.dispose()
    }
  }

}