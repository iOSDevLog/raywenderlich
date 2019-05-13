import io.reactivex.disposables.CompositeDisposable
import io.reactivex.subjects.PublishSubject

fun main(args: Array<String>) {

  exampleOf("PublishSubject") {

    val subscriptions = CompositeDisposable()

    val dealtHand = PublishSubject.create<List<Pair<String, Int>>>()

    fun deal(cardCount: Int) {
      val deck = cards
      var cardsRemaining = 52
      val hand = mutableListOf<Pair<String, Int>>()

      (0 until cardCount).forEach {
        val randomIndex = (0 until cardsRemaining).random()
        hand.add(deck[randomIndex])
        deck.removeAt(randomIndex)
        cardsRemaining -= 1

      }

      // Add code to update dealtHand here

    }

    // Add subscription to dealtHand here

    deal(3)
  }
}