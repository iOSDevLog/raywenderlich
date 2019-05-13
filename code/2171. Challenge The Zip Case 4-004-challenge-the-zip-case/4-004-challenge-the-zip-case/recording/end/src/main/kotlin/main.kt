import io.reactivex.Observable
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.rxkotlin.Observables


fun main(args: Array<String>) {

  exampleOf("zip + scan") {

    val subscriptions = CompositeDisposable()

    val runtimeKeys = Observable.fromIterable(runtimes.keys)
    val runtimeValues = Observable.fromIterable(runtimes.values)

    val scanTotals = runtimeValues.scan { a, b -> a + b }

    val results = Observables.zip(runtimeKeys, runtimeValues, scanTotals) { key, value, total ->
      Triple(key, value, total)
    }

    subscriptions.add(
        results
            .subscribe {
              println("${it.first}: ${stringFrom(it.second)} (${stringFrom(it.third)})")
            })
  }
}