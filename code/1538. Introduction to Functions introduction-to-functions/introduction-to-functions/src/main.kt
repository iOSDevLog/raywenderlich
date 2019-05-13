/**
 *
 */
fun main(args: Array<String>) {
    fun printMyName() {
        println("My name is Kevin Moore.")
    }
    printMyName()

    fun printMultipleOfFive(value: Int) {
        println("${value} * 5 = ${value * 5}")
    }
    printMultipleOfFive(value = 10)

    fun printMultipleOf(multiplier: Int, andValue: Int) {
        print("$multiplier * $andValue = ${multiplier *
                andValue}")
    }
    printMultipleOf(multiplier = 4, andValue = 2)

    fun printMultipleOf2(multiplier: Int, value: Int = 1) {
        println("$multiplier * $value = ${multiplier * value}")
    }
    printMultipleOf2(4)

    fun multiply(number: Int, multiplier: Int) : Int {
        return number * multiplier
    }
    val result = multiply(4, 2)
    println("Result = $result")

    fun multiplyAndDivide(number: Int, factor: Int) : Pair<Int, Int> {
        return Pair(number * factor, number / factor)
    }
    val results = multiplyAndDivide(4, 2)
    val product = results.first
    val quotient = results.second
    println("product = $product")
    println("quotient = $quotient")
}