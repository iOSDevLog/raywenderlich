/**
 *
 */
/*
class Person() {
    var firstName : String = "Sam"
        private set
}
*/
open class Person() {
    protected val firstName: String = "Sam"
}

class Student : Person() {
    fun printStudentData() {
        println("Students name is $firstName")
    }
}

fun main(args: Array<String>) {

}