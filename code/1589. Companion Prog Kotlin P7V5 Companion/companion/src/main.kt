/**
 *
 */
/*
class Student {
    companion object {
        const val ID_COUNTER = "Id Counter"
        var currentStudentId = 0
    }
}
class Student private constructor() {
	companion object {
		fun createStudent() : Student {
			return Student()
		}
	}
}
*/

class Student private constructor() {
    var firstname : String? = null
    var lastname : String? = null
    companion object Loader {
        fun loadStudent(jsonText: String) : Student {
            val student = Student()
            student.firstname = "first"
            student.lastname = "lastname"
            return student
        }
    }
//    companion object {
//        fun createStudent() : Student {
//            return Student()
//        }
//    }
}
fun main(args: Array<String>) {
    val student = Student.Loader.loadStudent("JSON Text")

}