import io.reactivex.Observable
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.rxkotlin.subscribeBy
import io.reactivex.subjects.PublishSubject


fun main(args: Array<String>) {

  exampleOf("ignoreElements") {

    val subscriptions = CompositeDisposable()

    val cannedProjects = PublishSubject.create<String>()

    subscriptions.add(
        cannedProjects.ignoreElements() // Returns a Completable, so no onNext in subscribeBy
            .subscribeBy {
              println("Completed")
            })

    cannedProjects.onNext(landOfDroids)
    cannedProjects.onNext(wookieWorld)
    cannedProjects.onNext(detours)

    cannedProjects.onComplete()
  }

  exampleOf("elementAt") {

    val subscriptions = CompositeDisposable()

    val quotes = PublishSubject.create<String>()

    subscriptions.add(
        quotes.elementAt(2) // Returns a Maybe, subscribe with onSuccess instead of onNext
            .subscribeBy(
                onSuccess = { println(it) },
                onComplete = { println("Completed") }
            ))

    quotes.onNext(mayTheOdds)
    quotes.onNext(liveLongAndProsper)
    quotes.onNext(mayTheForce)
  }

  exampleOf("filter") {

    val subscriptions = CompositeDisposable()

    subscriptions.add(
        Observable.fromIterable(tomatometerRatings)
            .filter { movie ->
              movie.rating >= 90
            }.subscribe {
              println(it)
            })
  }

  exampleOf("skipWhile") {

    val subscriptions = CompositeDisposable()

    subscriptions.add(
        Observable.fromIterable(tomatometerRatings)
            .skipWhile { movie ->
              movie.rating < 90
            }.subscribe {
              println(it)
            })

  }

  exampleOf("skipUntil") {

    val subscriptions = CompositeDisposable()

    val subject = PublishSubject.create<String>()
    val trigger = PublishSubject.create<Unit>()

    subscriptions.add(
        subject.skipUntil(trigger)
            .subscribe {
              println(it)
            })

    subject.onNext(episodeI.title)
    subject.onNext(episodeII.title)
    subject.onNext(episodeIII.title)

    trigger.onNext(Unit)

    subject.onNext(episodeIV.title)
  }

  exampleOf("distinctUntilChanged") {

    val subscriptions = CompositeDisposable()

    subscriptions.add(
        Observable.just(Droid.R2D2, Droid.C3PO, Droid.C3PO, Droid.R2D2)
            .distinctUntilChanged()
            .subscribe {
              println(it)
            })
  }

}