fun exampleOf(description: String, action: () -> Unit) {
  println("\n--- Example of: $description ---")
  action()
}

const val episodeI = "The Phantom Menace"
const val episodeII = "Attack of the Clones"
const val theCloneWars = "The Clone Wars"
const val episodeIII = "Revenge of the Sith"
const val solo = "Solo: A Star Wars Story"
const val rogueOne = "Rogue One: A Star Wars Story"
const val episodeIV = "A New Hope"
const val episodeV = "The Empire Strikes Back"
const val episodeVI = "Return of the Jedi"
const val episodeVII = "The Force Awakens"
const val episodeVIII = "The Last Jedi"
const val episodeIX = "Episode IX"

const val luke = "Luke Skywalker"
const val hanSolo = "Han Solo"
const val leia = "Princess Leia"
const val chewbacca = "Chewbacca"

const val lightsaber = "Lightsaber"
const val dl44 = "DL-44 Blaster"
const val defender = "Defender Sporting Blaster"
const val bowcaster = "Bowcaster"

fun stringFrom(minutes: Int): String {
  val hours = minutes / 60
  val min = minutes % 60
  return String.format("%d:%02d", hours, min)
}

val runtimes = mapOf(
    episodeI to 136,
    episodeII to 142,
    theCloneWars to 98,
    episodeIII to 140,
    solo to 142,
    rogueOne to 142,
    episodeIV to 121,
    episodeV to 124,
    episodeVI to 134,
    episodeVII to 136,
    episodeVIII to 152
)