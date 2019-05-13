package com.raywenderlich.android.creatures.domain.interactor

import io.reactivex.SingleObserver
import io.reactivex.disposables.Disposable


/**
 * Default [SingleObserver] base class to define
 */
// TODO: remove if not used
open class BaseSingleObserver<T> : SingleObserver<T> {
  override fun onSubscribe(d: Disposable) { }
  override fun onSuccess(t: T) { }
  override fun onError(exception: Throwable) { }
}