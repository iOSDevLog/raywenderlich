/**
 *
 */
fun main(args: Array<String>) {
    val number = 10
//    Here we are creating number value set to 10
    when (number) {
        0 -> println("Zero")
//        Here we checking if the number equals 0 and printing Zero
        10 -> println("It's ten!")
//        Here we checking if the number equals 10 and printing It's ten
        else -> println("Non-zero")
//        For anything else we are printing non-zero
    }

    val animal = "Dog"
    when (animal) {
        "Cat", "Dog" ->
            println("Animal is a house pet.")
        else ->
            println("Animal is not a house pet.")
    }

    when (number) {
        in 1..9 ->
            print("Between 1 and 9")
        in 10..20 ->
            print("Between 10 and 20")
        else ->
            print("Some other number")
    }

    when {
        number % 2 == 0 ->
            println("Even")
        else ->
            print("Odd")
    }

    val testValue = 10
    val result = when {
        testValue < 10 -> "Less than 10"
        testValue > 10 -> "Greater than 10"
        else -> "is equal to 10"
    }
    println(result)

}