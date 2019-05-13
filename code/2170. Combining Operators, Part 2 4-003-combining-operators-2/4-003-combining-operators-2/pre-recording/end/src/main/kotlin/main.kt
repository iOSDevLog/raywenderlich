import io.reactivex.Observable
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.rxkotlin.Observables
import io.reactivex.rxkotlin.subscribeBy
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
            }
    )
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

  exampleOf("merge") {

    val subscriptions = CompositeDisposable()

    val filmTrilogies = PublishSubject.create<String>()
    val standaloneFilms = PublishSubject.create<String>()

    subscriptions.add(Observable.merge(filmTrilogies, standaloneFilms)
        .subscribe {
          println(it)
        })

    filmTrilogies.onNext(episodeI)
    filmTrilogies.onNext(episodeII)

    standaloneFilms.onNext(theCloneWars)

    filmTrilogies.onNext(episodeIII)

    standaloneFilms.onNext(solo)
    standaloneFilms.onNext(rogueOne)

    filmTrilogies.onNext(episodeIV)
  }

  exampleOf("mergeWith") {

    val subscriptions = CompositeDisposable()

    val filmTrilogies = PublishSubject.create<String>()
    val standaloneFilms = PublishSubject.create<String>()

    subscriptions.add(
        filmTrilogies.mergeWith(standaloneFilms)
            .subscribe {
              println(it)
            })

    filmTrilogies.onNext(episodeI)
    filmTrilogies.onNext(episodeII)

    standaloneFilms.onNext(theCloneWars)

    filmTrilogies.onNext(episodeIII)

    standaloneFilms.onNext(solo)
    standaloneFilms.onNext(rogueOne)

    filmTrilogies.onNext(episodeIV)
  }

  exampleOf("combineLatest") {

    val subscriptions = CompositeDisposable()

    val characters = PublishSubject.create<String>()
    val primaryWeapons = PublishSubject.create<String>()

    subscriptions.add(
        Observables.combineLatest(characters, primaryWeapons) { character, weapon ->
          "$character: $weapon"
        }.subscribe {
          println(it)
        })

    characters.onNext(luke)
    primaryWeapons.onNext(lightsaber)
    characters.onNext(hanSolo)
    primaryWeapons.onNext(dl44)
    characters.onNext(leia)
    primaryWeapons.onNext(defender)
    characters.onNext(chewbacca)
    primaryWeapons.onNext(bowcaster)
  }

  exampleOf("zip") {

    val subscriptions = CompositeDisposable()

    val characters = PublishSubject.create<String>()
    val primaryWeapons = PublishSubject.create<String>()

    subscriptions.add(
        Observables.zip(characters, primaryWeapons) { character, weapon ->
          "$character: $weapon"
        }.subscribe {
          println(it)
        })

    characters.onNext(luke)
    primaryWeapons.onNext(lightsaber)
    characters.onNext(hanSolo)
    primaryWeapons.onNext(dl44)
    characters.onNext(leia)
    primaryWeapons.onNext(defender)
    characters.onNext(chewbacca)
    primaryWeapons.onNext(bowcaster)
  }

  exampleOf("amb") {

    val subscriptions = CompositeDisposable()

    val prequelEpisodes = PublishSubject.create<String>()
    val originalEpisodes = PublishSubject.create<String>()

    subscriptions.add(
        prequelEpisodes.ambWith(originalEpisodes)
            .subscribe {
              println(it)
            })

    originalEpisodes.onNext(episodeIV)
    prequelEpisodes.onNext(episodeI)
    prequelEpisodes.onNext(episodeII)
    originalEpisodes.onNext(episodeV)
  }

  exampleOf("reduce") {

    val subscriptions = CompositeDisposable()

    subscriptions.add(
        Observable.fromIterable(runtimes.values)
            .reduce { a, b -> a + b }
            .subscribeBy(onSuccess = {
              println(stringFrom(it))
            }))
  }

  exampleOf("scan") {

    val subscriptions = CompositeDisposable()

    subscriptions.add(
        Observable.fromIterable(runtimes.values)
            .scan { a, b -> a + b }
            .subscribeBy {
              println(stringFrom(it))
            })
  }

}