/**
 *
 */
fun main(args: Array<String>) {
/*
    class Person {
    }

    val person = Person()

    class Person {
        var firstName: String = ""
        var lastName: String = ""
    }

    class Person(var firstName: String, var lastName: String) {
    }

    val person = Person("Sam", "Gamgee")

    class Person(var firstName: String) {
        var lastName: String? = null

        constructor(firstName: String, lastName: String) : this(firstName) {
            this.lastName = lastName
        }
    }

    val person = Person("Sam")
    val person2 = Person("Sam", "Gamgee")

*/
    class Person(var firstName: String, var lastName: String = "Gamgee") {
    }

    val person = Person("Sam")
    val person2 = Person("Sam", "Gamgee")
    println("Person1 = ${person.firstName} ${person.lastName}")
    println ("Person2 = ${person2.firstName} ${person2.lastName}")
}