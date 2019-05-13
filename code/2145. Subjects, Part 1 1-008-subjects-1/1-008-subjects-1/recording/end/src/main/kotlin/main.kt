import io.reactivex.rxkotlin.subscribeBy
import io.reactivex.subjects.PublishSubject

fun main(args: Array<String>) {

  exampleOf("PublishSubject") {

    val quotes = PublishSubject.create<String>()

    quotes.onNext(itsNotMyFault)

    val subscriptionOne = quotes.subscribeBy(
        onNext = { printWithLabel("1)", it) },
        onComplete = { printWithLabel("1)", "Complete") }
        )

    quotes.onNext(doOrDoNot)

    val subscriptionTwo =  quotes.subscribeBy(
        onNext = { printWithLabel("2)", it) },
        onComplete = { printWithLabel("2)", "Complete") }
    )

    quotes.onNext(lackOfFaith)

    subscriptionOne.dispose()

    quotes.onNext(eyesCanDeceive)

    quotes.onComplete()

    val subscriptionThree = quotes.subscribeBy(
        onNext = { printWithLabel("3)", it) },
        onComplete = { printWithLabel("3)", "Complete") }
    )

    quotes.onNext(stayOnTarget)

    subscriptionTwo.dispose()
    subscriptionThree.dispose()
  }

}