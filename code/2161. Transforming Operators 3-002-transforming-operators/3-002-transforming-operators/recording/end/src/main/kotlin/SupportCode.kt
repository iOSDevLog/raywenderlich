import io.reactivex.subjects.BehaviorSubject

fun exampleOf(description: String, action: () -> Unit) {
  println("\n--- Example of: $description ---")
  action()
}

const val episodeI = "Episode I - The Phantom Menace"
const val episodeII = "Episode II - Attack of the Clones"
const val episodeIII = "Episode III - Revenge of the Sith"
const val episodeIV = "Episode IV - A New Hope"
const val episodeV = "Episode V - The Empire Strikes Back"
const val episodeVI = "Episode VI - Return Of The Jedi"
const val episodeVII = "Episode VII - The Force Awakens"
const val episodeVIII = "Episode VIII - The Last Jedi"
const val episodeIX = "Episode IX - Episode IX"

val episodes = listOf(episodeI, episodeII, episodeIII, episodeIV, episodeV, episodeVI, episodeVII, episodeVIII, episodeIX)

fun String.romanNumeralIntValue(): Int {

  // https://gist.github.com/eadred/a902ec625f2ecb0a98841e78e16438d6

  val lookup: Map<Char, Int> = mapOf(
      Pair('I', 1),
      Pair('V', 5),
      Pair('X', 10),
      Pair('L', 50),
      Pair('C', 100),
      Pair('D', 500),
      Pair('M', 1000)
  )

  fun accumulate(currentValue: Int?, lastValueAndTotal: Pair<Int, Int>): Pair<Int, Int> {
    if (currentValue == null) return lastValueAndTotal
    val mult = if (lastValueAndTotal.first > currentValue) -1 else 1
    return Pair(currentValue, lastValueAndTotal.second + (mult * currentValue))
  }

  return this.map { lookup[it] }
      .foldRight(Pair(0, 0), ::accumulate)
      .second
}

data class Jedi(val rank: BehaviorSubject<JediRank>)

enum class JediRank(val value: String) {
  Youngling("Youngling"),
  Padawan("Padawan"),
  JediKnight("Jedi Knight"),
  JediMaster("Jedi Master"),
  JediGrandMaster("Jedi Grand Master")
}