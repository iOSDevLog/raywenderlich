/**
 *
 */
fun main(args: Array<String>) {
    var namesAndScores = mapOf("Anna" to 2, "Brian" to 2, "Craig" to 8, "Donna" to 6)
    println(namesAndScores)

    val testValue = 10
    val result = when {
        testValue < 10 -> "Less than 10"
        testValue > 10 -> "Greater than 10"
        else -> "is equal to 10"
    }
    println(result)

    // Accessing values

    namesAndScores = mapOf("Anna" to 2, "Brian" to 2, "Craig" to 8, "Donna" to 6)
    println(namesAndScores["Anna"])

    //namesAndScores["Greg"] = 5 // error - No set method

    namesAndScores.isEmpty()  //  false
    namesAndScores.count()    //  4

    // Modifying maps

    val bobData = mutableMapOf("name" to "Bob",
        "profession" to "Card Player",
        "city" to "Oakland",
        "country" to "USA")

    bobData["city"] = "San Francisco" // Update

    bobData["profession"] = "Mailman" // Update

    bobData.remove("city") // Delete

    /// Iterating through maps

    for ((player, score) in namesAndScores) {
        println("$player - $score")
    }

    for (player in namesAndScores.keys) {
        print("$player, ")
    }
}