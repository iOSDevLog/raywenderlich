/**
 *
 */
fun main(args: Array<String>) {
    val values = listOf(24, 5, 10, 4)
    println(values.filter { it > 5 })

    val names = listOf("Sam", "Fred", "Samuel", "Alice")
    println(names.first { it.length > 4 })

    var cities = listOf("Los Angeles", "San Francisco", "New York", "San Antonio")
    println(cities.any { it == "San Antonio" } )

    cities = listOf("Los Angeles", "San Francisco", "New York", "San Antonio")
    println(cities.all { it.length > 6 } )

}