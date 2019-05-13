import io.reactivex.Observable
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.rxkotlin.subscribeBy
import io.reactivex.rxkotlin.toObservable

fun main(args: Array<String>) {

  exampleOf("subscribe") {

    val observable = Observable.just(episodeIV, episodeV, episodeVI)

    observable.subscribeBy(onNext = {
      println(it)
    }, onComplete = {
      println("Completed")
    })

    observable.subscribe { element ->
      println(element)
    }
  }

  exampleOf("empty") {

    val observable = Observable.empty<Unit>()

    observable.subscribeBy(onNext = {
      println(it)
    }, onComplete = {
      println("Completed")
    })

  }

  exampleOf("never") {

    val observable = Observable.never<Any>()

    observable.subscribeBy(onNext = {
      println(it)
    }, onComplete = {
      println("Completed")
    })
  }

  exampleOf("dispose") {

    val mostPopular: Observable<String> = Observable.just(episodeV, episodeIV, episodeVI)

    val subscription = mostPopular.subscribe {
      println(it)
    }

    subscription.dispose()
  }

  exampleOf("CompositeDisposable") {

    val subscriptions = CompositeDisposable()

    subscriptions.add(listOf(episodeVII, episodeI, rogueOne)
        .toObservable()
        .subscribeBy {
          println(it)
        })

    subscriptions.dispose()
  }

}