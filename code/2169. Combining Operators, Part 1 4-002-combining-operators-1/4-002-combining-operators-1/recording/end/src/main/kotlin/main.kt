import io.reactivex.Observable
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.subjects.PublishSubject

fun main(args: Array<String>) {

  exampleOf("startWith") {

    val subscriptions = CompositeDisposable()

    val prequelEpisodes = Observable.just(episodeI, episodeII, episodeIII)

    val flashback = prequelEpisodes.startWith(listOf(episodeIV, episodeV))

    subscriptions.add(
        flashback
            .subscribe { episode ->
              println(episode)
            })
  }

  exampleOf("concatWith") {

    val subscriptions = CompositeDisposable()

    val prequelTrilogy = Observable.just(episodeI, episodeII, episodeIII)
    val originalTrilogy = Observable.just(episodeIV, episodeV, episodeVI)

    subscriptions.add(
        prequelTrilogy
            .concatWith(originalTrilogy)
            .subscribe { episode ->
              println(episode)
            })
  }

  exampleOf("mergeWith") {

    val subscriptions = CompositeDisposable()

    val filmTrilogies = PublishSubject.create<String>()
    val standAloneFilms = PublishSubject.create<String>()

    subscriptions.add(
        filmTrilogies.mergeWith(standAloneFilms)
            .subscribe {
              println(it)
            })

    filmTrilogies.onNext(episodeI)
    filmTrilogies.onNext(episodeII)

    standAloneFilms.onNext(theCloneWars)

    filmTrilogies.onNext(episodeIII)

    standAloneFilms.onNext(solo)
    standAloneFilms.onNext(rogueOne)

    filmTrilogies.onNext(episodeIV)
  }
}