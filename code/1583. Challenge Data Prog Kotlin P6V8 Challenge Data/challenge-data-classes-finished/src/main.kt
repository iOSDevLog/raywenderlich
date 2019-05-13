/**
 *
 */

fun main(args: Array<String>) {

    /**
     * Write a data class named Student with a firstName, lastName of type String
     * and a grade with a type Char
     */

    data class Student(
            val firstName: String,
            val lastName: String,
            val grade: Char)


    /**
     * Create a variable named sam that is a student with the first name "Sam"
     * and a last name of Gamgee and a grade of 'A'
     */

    var sam = Student("Sam", "Gamgee", 'A')
    println("Sam has a grade of ${sam.grade}")

    /**
     * Now make a copy of sam but with a grade of 'B'
     */


    sam = sam.copy(grade = 'B')
    println("Sam has a grade of ${sam.grade}")
}