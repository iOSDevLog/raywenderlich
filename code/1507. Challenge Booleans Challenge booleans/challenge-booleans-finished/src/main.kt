/**
 *
 */
fun main(args: Array<String>) {
/*
 BOOLEANS
 Create a constant called `myAge` and set it to your age.
 Then, create a constant called `isTeenager` that uses Boolean logic
 to determine if the age denotes someone in the age range of 13 to 19.
 */
    val myAge = 30
    val isTeenager = myAge >= 13 && myAge <= 19
    println("isTeenager $isTeenager")

/*
 Create another constant called `theirAge` and set it to the age of an person which is 30.
 Then, create a constant called `bothTeenagers` that uses
 Boolean logic to determine if both you and him are teenagers.
 */
    val theirAge = 30
    val bothTeenagers = theirAge >= 13 && theirAge <= 19 && isTeenager
    println("bothTeenagers $bothTeenagers")

/*
 Create a constant called student and set it to your name as a string.
 Create a constant called author and set it to Kevin Moore.
 Create a constant called `authorIsStudent` that uses string equality
 to determine if student and author are equal.
 */
    val student = "Joe Bloggs"
    val author = "Kevin Moore"
    val authorIsStudent = student == author
    println("authorIsStudent $authorIsStudent")

/*
 Create a constant called `studentBeforeAuthor` which uses string
 comparison to determine if student comes before author.
 */
    val studentBeforeAuthor = student < author
    println("studentBeforeAuthor $studentBeforeAuthor")


/*
 IF STATEMENTS AND BOOLEANS
 Use the constant called `myAge` and initialize it with your age.
 Write an if statement to print out Teenager if your age is between 13 and 19,
 and Not a teenager if your age is not between 13 and 19.
 */

    if (myAge >= 13 && myAge <= 19) {
        val newAge = myAge + 1
        println("Teenager. newAge = $newAge")
    } else {
        println("Not a teenager")
    }

/*
 Create a constant called `answer` and an if expression to set it
 equal to the result you print out for the same cases in the above exercise.
 Then print out answer.
 */
    val answer = if (myAge >= 13 && myAge <= 19)   "Teenager" else "Not a teenager"
    println(answer)
}