/**
 *
 */
object MySingleton {
    fun doMyStuff(data : String) {
        println("This is my data $data")
    }

    val myConstant = "This is my Constant"
}

fun main(args: Array<String>) {
    MySingleton.doMyStuff("Hello there " +
            MySingleton.myConstant)

}