import io.reactivex.Observable
import io.reactivex.rxkotlin.toObservable

fun main(args: Array<String>) {

  exampleOf("creating observables") {
    val mostPopular: Observable<String> = Observable.just(episodeV)
    val originalTrilogy = Observable.just(episodeIV, episodeV, episodeVI)
    val prequelTrilogy = Observable.just(listOf(episodeI, episodeII, episodeIII))
    val sequelTrilogy = Observable.fromIterable(listOf(episodeVII, episodeVIII, episodeIX))
    val stories = listOf(solo, rogueOne).toObservable()
  }

}