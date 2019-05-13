import java.lang.Math.sqrt

/**
 *
 */
fun main(args: Array<String>) {
    /**
     * Create a constant called range and set it equal to a range
     * starting at 1 and ending with 10 inclusive.
     * Write a for loop which iterates over this range and print the
     * square of each number
     */
    val range = 1..10
    for (i in range) {
        val square = i * i
        println("$square")
    }


    /**
     * Write a for loop to iterate over the same range as in the exercise above
     * and print the square root of each number using the sqrt function.
     * You'll need to convert your loop constant
     */
    for (i in range) {
        val squareRoot = sqrt(i.toDouble())
        println("$squareRoot")
    }


    /**
     * Create a variable named sum. Write a for loop with a constant named row
     * starting at 0 and going to 8. Inside of the loop check the row variable
     * and if it is odd, add another for loop that uses a column variable to go
     * from 0 to 8. In that loop add to the sum variable the muliptlication of
     * row * column.
     * Then print out sum
     */
    var sum = 0
    for (row in 0..8)
        if (row % 2 == 1) {
            for (column in 0..8) {
                sum += row * column
            }
        }
    println("$sum")
}