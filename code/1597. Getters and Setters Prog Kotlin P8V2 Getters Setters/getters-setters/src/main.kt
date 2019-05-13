/**
 *
 */
/*
class Person() {
    val salutation = "Mr."
    var firstName : String? = null
    var lastName : String? = null
}
*/

class Person(var firstName : String? = null, var lastName : String? = null) {
    var itemList : ArrayList<String> = ArrayList<String>()
        set(value) {
            field = value
            // Some other code
        }
    val fullName : String
        get() {
            return firstName + " " + lastName
        }

}

fun main(args: Array<String>) {
    val person = Person("Sam", "Smith")
    println("Person: ${person.firstName} ${person.lastName}")

}