/**
 *
 */

fun main(args: Array<String>) {

/*
 ### Maps

 Create a Map with the following keys: name, profession, country, state, and city.
 For the values, put your own name, profession, country, state, and city.
 */

    val ray = mutableMapOf("name" to  "Ray",
    "profession" to  "Tutorial Writer",
    "country" to  "USA",
    "state" to  "VA",
    "city" to  "McGaheysville")

    for ((index, value) in ray) {
        println("Found $value at index $index")
    }
/*
 You suddenly decide to move to Albuquerque.
 Update your city to Albuquerque, your state to New Mexico,
 and your country to USA.
 */

    ray["city"] = "Albuquerque"
    ray["state"] = "New Mexico"
    ray["country"] = "USA"

/*
Given a Map in the above format, write a function that
prints a given player's city and state.
*/

    fun printLocation(person : Map<String, String>) {
        val state = if (person.containsKey("state")) person["state"] else ""
        val city = if (person.containsKey("city")) person["city"] else ""
        print("Person lives in $city, $state")
    }

    printLocation(ray)


}
