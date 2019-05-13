/**
 *
 */
class Person(var firstName: String, var lastName : String) {
    lateinit var fullName : String
    init {
        fullName = firstName + " " + lastName
    }
    fun printFullName() {
        if (!this::fullName.isInitialized) {
            fullName = firstName + " " + lastName
        }
        println(fullName)
    }

}
fun main(args: Array<String>) {
    Person("Sam", "Gamgee").printFullName()
}