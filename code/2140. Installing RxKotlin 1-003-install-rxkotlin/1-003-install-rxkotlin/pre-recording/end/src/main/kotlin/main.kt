import io.reactivex.Observable

fun main(args: Array<String>) {
  Observable.just("Hello, RxKotlin!")
      .subscribe {
        println(it)
      }
}