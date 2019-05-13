import io.reactivex.Observable
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.rxkotlin.subscribeBy
import io.reactivex.subjects.BehaviorSubject
import io.reactivex.subjects.PublishSubject

fun main(args: Array<String>) {

  exampleOf("map") {

    val subscriptions = CompositeDisposable()

    subscriptions.add(
        Observable.fromIterable(episodes)
            .map {
              val components = it.split(" ").toMutableList()
              val number = components[1].romanNumeralIntValue()
              val numberString = number.toString()
              components[1] = numberString
              components.joinToString(" ")
            }
            .subscribeBy {
              println(it)
            })
  }

  exampleOf("flatMap") {

    val subscriptions = CompositeDisposable()

    val ryan = Jedi(BehaviorSubject.createDefault<JediRank>(JediRank.Youngling))
    val charlotte = Jedi(BehaviorSubject.createDefault<JediRank>(JediRank.Youngling))

    val student = PublishSubject.create<Jedi>()

    subscriptions.add(
        student
            .flatMap {
              it.rank
            }
            .subscribeBy {
              println(it)
            })

    student.onNext(ryan)

    ryan.rank.onNext(JediRank.Padawan)

    student.onNext(charlotte)

    ryan.rank.onNext(JediRank.JediKnight)

    charlotte.rank.onNext(JediRank.JediMaster)
  }

  exampleOf("switchMap") {

    val subscriptions = CompositeDisposable()

    val ryan = Jedi(BehaviorSubject.createDefault<JediRank>(JediRank.Youngling))
    val charlotte = Jedi(BehaviorSubject.createDefault<JediRank>(JediRank.Youngling))

    val student = PublishSubject.create<Jedi>()

    subscriptions.add(
        student
            .switchMap {
              it.rank
            }
            .subscribeBy {
              println(it)
            })

    student.onNext(ryan)

    ryan.rank.onNext(JediRank.Padawan)

    student.onNext(charlotte)

    ryan.rank.onNext(JediRank.JediKnight)

    charlotte.rank.onNext(JediRank.JediMaster)
  }
}