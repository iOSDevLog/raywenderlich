/**
 *
 */
fun main(args: Array<String>) {
/*
 ### Lists
 Create a list with the following states that you have lived in:
 */

    val states = mutableListOf("VA", "CA", "WA", "LA")

    // Add a new State
    states.add("OH")
    println(states)

/*
Given a function to print out all states but the third index
*/

    fun printStates(states : List<String>) {

        for (i in 0..states.size-1) {
            if (i != 3) {
                println("$i ${states[i]}")
            }
        }
    }

    printStates(states)
}
