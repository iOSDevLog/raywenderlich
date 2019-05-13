/**
 *
 */
fun main(args: Array<String>) {
    class Person(var firstName: String, var lastName: String) {
        lateinit var fullName : String
        init {
            fullName = firstName + " " + lastName
            println("In Init 1")
        }

        init {
            println("In Init 2")
        }
    }

    val person = Person("Sam", "Gamgee")
}