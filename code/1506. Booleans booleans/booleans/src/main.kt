/**
 *
 */
fun main(args: Array<String>) {
    val yes1: Boolean = true
    val no1: Boolean = false

    val yes2 = true
    val no2 = false
    println("yes1 = yes2 ${yes1 == yes2} no1=no2 ${no1==no2}")

    val doesOneEqualTwo = (1 == 2)
    println("doesOneEqualTwo = ${doesOneEqualTwo}")

    val doesOneNotEqualTwo = (1 != 2)
    println("doesOneNotEqualTwo = ${doesOneNotEqualTwo}")

    val longName = "Samantha".length > 5
    println("longName = ${longName}")

    val and = true && true
    println("and = ${and}")

    val or = true || false
    println("or = ${or}")

    val andTrue = 1 < 2 && 4 > 3
    val andFalse = 1 < 2 && 3 > 4
    println("andTrue = ${andTrue}")
    println("andFalse = ${andFalse}")

    val orTrue = 1 < 2 || 3 > 4
    val orFalse = 1 == 2 || 3 == 4
    println("orTrue = ${orTrue}")
    println("orFalse = ${orFalse}")

    val guess = "dog"
    val dogEqualsCat = guess == "cat"
    println("dogEqualsCat = ${dogEqualsCat}")

    val order = "cat" < "dog"
    println("order = ${order}")

    val a = 5
    val b = 10

    val min: Int
    if (a < b) {
        min = a
    } else {
        min = b
    }
    println("min = ${min}")

}