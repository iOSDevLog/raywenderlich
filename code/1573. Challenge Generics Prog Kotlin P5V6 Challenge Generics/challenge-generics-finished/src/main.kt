/**
 *
 */
fun main(args: Array<String>) {

    /**
     * Create a function named printItem that prints out a generic parameter.
     * Call the parameter "item"
     */



    fun <T>  printItem(item : T) {
        println("My Item $item")
    }

    printItem(1)
    printItem("Hello")



    /**
     * Create a function named printList that takes a generic list as a parameter
     * and prints out each item
     */

    fun <T> printList(list : List<T>) {
        for (item in list) {
            println("List item: $item")
        }
    }

    printList(listOf("Sam", "Fred"))
}
