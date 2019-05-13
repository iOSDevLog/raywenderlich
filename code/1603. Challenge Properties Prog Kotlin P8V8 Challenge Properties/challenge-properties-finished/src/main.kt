import kotlin.properties.Delegates

/**
 * Copy the Course class you created in the lateinit challenge
 * and add a courseDescription String that is created with the lazy function
 * Have the returned string contain the className and the teacherName
 */
/**
 *  add a room String variable that is an Observable, has a "No Room" initial value
 *  and prints out the new value
 */
data class Course(var className: String) {
    val courseDescription : String by lazy {
        "Course ${className} taught by $teacherName"
    }
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
 * Add a main function, create a Course and set the teacher name,
 * room and print out the courseDescription
 */
fun main(args: Array<String>) {
    val course = Course("Math")
    course.setTeacherName("Ms Price")
    course.room = "Library"
    println("Course description ${course.courseDescription}")
    println("Course is ${course}")

}