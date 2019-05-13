import kotlin.properties.Delegates

/**
 *
 */
data class Course(var className: String) {

    val scienceCourse: Course by lazy {
        Course("Science")
    }

    var room: String by Delegates.observable("No Room") { property, oldValue, newValue ->
        println("New value is $newValue")
    }
}
class MapCourse(val map: Map<String, Any?>) {
    val room : String by map
    val teacher : String by map
}

fun main(args: Array<String>) {
    val course = MapCourse(mapOf("room" to "Room 1",  "teacher" to "Ms Price"))
    println("Course Room is ${course.room} teacher is: ${course.teacher}")
}