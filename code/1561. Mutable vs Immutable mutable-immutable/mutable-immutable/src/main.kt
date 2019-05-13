/**
 *
 */
fun main(args: Array<String>) {
    val names = ArrayList<String>()
    names.add("Sam")
    names.add("Fred")

    fun printNames(names : ArrayList<String>) {
        println(names)
        names.remove(0) // Intellij Warning/Error
    }

    fun printNames(names : List<String>) {
        println(names)
        names.remove(0) // Compiler error
    }

    val name = "Sam"
    name = "Fred" // Compiler Error
}