/**
 *
 */
fun main(args: Array<String>) {
    var result: Int? = 30
    println(result)
    val newResult = result?.plus(5)


    var x : Int? = null
    if (x != null) {
        x = x + 1
    }
    println(x)

    println(result!! + 1)

    var authorName: String? = "Kevin Moore"
    var authorAge: Int? = 30
    var unwrappedAuthorName = authorName!!
    println("Author is $unwrappedAuthorName")
    authorName = null
//    println("Author is ${authorName!!}")
    if (authorName != null) {
        print("Author is ${authorName!!}")
    } else {
        print("No author.")
    }
    authorName?.let { name ->
        print("Author is $name")
    }
    authorName?.let {
        print("Author is $it")
    }
    var nullableInt: Int? = 10
    var mustHaveResult = nullableInt ?: 0

}
