/**
 *
 */
class Grade(
        var letter: Char,
        var points: Double,
        var credits: Double
) {
    override fun toString(): String {
        return "Letter: $letter Points:$points Credits:$credits"
    }
}

open class Person(
        var firstName: String,
        var lastName: String)     {
    override fun toString(): String {
        return firstName + " " + lastName
    }
}

open class Student(
        firstName: String,
        lastName: String,
        var grades: ArrayList<Grade> = ArrayList()) : Person(firstName, lastName) {


    open fun recordGrade(grade: Grade) {
        grades.add(grade)
    }

    override fun toString(): String {
        var result = firstName + " " + lastName
        result += "\nGrades: "
        grades.forEach { result += it }
        return result
    }
}
open class BandMember(
        firstName: String,
        lastName: String)
    : Student(firstName, lastName) {
    open var minimumPracticeTime = 2
}

class OboePlayer(
        firstName: String,
        lastName: String)
    : BandMember(firstName, lastName) {
    // This is an example of an override, which we’ll cover soon.
    override var minimumPracticeTime: Int
        get () {
            return super.minimumPracticeTime * 2
        }
        set(value) {
            super.minimumPracticeTime = value / 2
        }
}

class StudentAthlete(
        firstName: String,
        lastName: String)
    : Student(firstName, lastName) {
    var failedClasses = ArrayList<Grade>()

    override fun recordGrade(grade: Grade) {
        super.recordGrade(grade) // Explain this

        if (grade.letter == 'F') {
            failedClasses.add(grade)
        }
    }

    var isEligible: Boolean = true
        get()
        {
            return failedClasses.size < 3
        }
}

fun phonebookName(person: Person) : String {
    return "${person.lastName}, ${person.firstName}"
}
fun afterClassActivity(student: Student) : String {
    return "Goes home!"
}

fun afterClassActivity(student: BandMember) : String {
    return "Goes to practice!"
}

fun main(args: Array<String>) {
    val john = Person( "Johnny", "Appleseed")
    val jane = Student( "Jane", "Appleseed")
    val history = Grade( 'B', points = 9.0, credits = 3.0)
    jane.recordGrade(history)
    println("John = $john Jane = $jane")

    val person = Person(firstName = "Johnny", lastName = "Appleseed")
    val oboePlayer = OboePlayer(firstName = "Jane", lastName = "Appleseed")

    println(phonebookName(person)) // Appleseed, Johnny
    println(phonebookName(oboePlayer)) // Appleseed, Jane

    var hallMonitor = Student(firstName = "Jill",
            lastName = "Bananapeel")

    hallMonitor = oboePlayer
    println((hallMonitor as? BandMember)?.minimumPracticeTime) // 4


    (hallMonitor as? BandMember)?.let {
        println("""This hall monitor is a band member and practices
            at least ${hallMonitor.minimumPracticeTime})
    hours per week.""")
    }
    println(afterClassActivity(oboePlayer)) // Goes to practice!
    println(afterClassActivity(oboePlayer as Student)) // Goes home!

    val athelete1 = StudentAthlete("John", "Strong")
    val athelete2 = StudentAthlete("Sue", "Fast")

    athelete1.recordGrade(Grade('A', 2.0, 3.0))
    println("Athelete1 is ${athelete1.isEligible}")
    athelete2.recordGrade(Grade('F', 1.0, 3.0))
    athelete2.recordGrade(Grade('F', 1.0, 3.0))
    athelete2.recordGrade(Grade('F', 1.0, 3.0))
    println("Athelete2 is ${athelete2.isEligible}")
    println("Athelete2 is ${athelete2.failedClasses.size}")
}