/**
 *
 */
fun main(args: Array<String>) {
/*
 ### INTRODUCTION TO Nullables
 
 Make an Nullable `String` called `myFavoriteSong`. If you have a favorite song,
 set it to a string representing that song. If you have more than one favorite song
 or no favorite, set the Nullable to `null`.
 */

    var myFavoriteSong: String? = "The Final Countdown" // or null

/*
 Create a method named printFavoriteSong that takes a nullable song
 and print the value
 */
    fun printFavoriteSong(song : String?) {
        println(song)
    }

/*
 Print your favorite song
 Print null. What happens?
 */
    printFavoriteSong(myFavoriteSong)
    myFavoriteSong = null
    printFavoriteSong(myFavoriteSong)
}
