import kotlin.properties.Delegates

/**
 * Create a class named Course that takes a className String parameter
 * Add a private lateinit variable for the Teacher's name
 * Then create a setTecherName function that sets that variable
 */
class Course(var className: String) {

    var room: String by Delegates.observable("No Room") {
        property, oldValue, newValue ->
        println("New value is $newValue")
    }
    private lateinit var teacherName: String

    fun setTeacherName(teacher : String) {
        this.teacherName = teacher
    }
 }

/**
 * Add a main function, create a Course and set the teacher name
 */
fun main(args: Array<String>) {
    val course = Course("Math")
    course.setTeacherName("Ms Price")
    val scienceCourse : Course by lazy {
        Course("Science")
    }
}