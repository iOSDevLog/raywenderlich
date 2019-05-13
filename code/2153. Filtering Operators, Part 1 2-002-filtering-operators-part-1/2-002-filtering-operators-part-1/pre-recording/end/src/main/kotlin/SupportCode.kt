fun exampleOf(description: String, action: () -> Unit) {
  println("\n--- Example of: $description ---")
  action()
}

const val landOfDroids = "Land of Droids"
const val wookieWorld = "Wookie World"
const val detours = "Detours"

const val mayTheOdds = "And may the odds be ever in your favor"
const val liveLongAndProsper = "Live long and prosper"
const val mayTheForce = "May the Force be with you"

data class Movie(val title: String, val rating: Int)

val episodeI = Movie("The Phantom Menace", 55)
val episodeII = Movie("Attack of the Clones", 66)
val episodeIII = Movie("Revenge of the Sith", 79)
val rogueOne = Movie("Rogue One", 85)
val episodeIV = Movie("A New Hope", 93)
val episodeV = Movie("The Empire Strikes Back", 94)
val episodeVI = Movie("Return Of The Jedi", 80)
val episodeVII = Movie("The Force Awakens", 93)
val episodeVIII = Movie("The Last Jedi", 91)
val tomatometerRatings = listOf(
    episodeI, episodeII, episodeIII, rogueOne, episodeIV, episodeV, episodeVI, episodeVII, episodeVIII)

enum class Droid {
  C3PO, R2D2
}
