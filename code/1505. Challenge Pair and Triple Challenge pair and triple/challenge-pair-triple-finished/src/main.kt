/**
 *
 */
fun main(args: Array<String>) {
/* Pairs and Triples

 Declare a constant Pair that contains two Int values. Use this to represent a date (month, day).
 */
    val date = Pair(8, 16)

/*
 In one line, read the day and month values into two constants.
 */
    val (month, day) = date
    println("month = $month day = $day")


/*
 Now create a Triple using the month, day and year */

    val dayOfMonth = Triple(8, 12, 2018)
    println("dayOfMonth = $dayOfMonth")
}