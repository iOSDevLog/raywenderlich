/**
 *
 */
/*
class Person {
    var firstName = ""

    fun setFirst(firstName : String) {
        this.firstName = firstName
    }
}
*/
class Person {
    var firstName = ""
    var child = Child()

    inner class Child {
        var firstName = ""
        fun printParentage() {
            println("Child ${this@Child.firstName} with parent ${this@Person.firstName}")
        }
    }
}
fun String.lastChar() : Char = this.get(this.length-1)

fun main(args: Array<String>) {
    val person = Person()
    person.firstName = "Sam"
    person.child.firstName = "Suzy"
    person.child.printParentage()

    println("Hello there ${"Sammy".lastChar()}")
}