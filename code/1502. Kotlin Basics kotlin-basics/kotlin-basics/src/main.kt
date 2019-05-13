/**
 *
 */
fun main(args: Array<String>) {
    val temperature = 37.5
    var count : Int = 5
    var name = "Sam"
    name = "Fred"

    count = 7
    fun calculateTemperature(celsius : Double ) : Double {
        return 9.0/5.0 * celsius + 32.0
    }

    println("Temp = ${calculateTemperature(20.0)}")
    println("Temp = ${calculateTemperature(50.0)}")
    val intValue = "32".toInt()
    println("intValue = $intValue")
    val intString = 32.toString()
    println("intString = $intString")

    if (intValue > 5) {
        println("Value is greater than 5")
    }
    val fahrenheit = 32
    when (fahrenheit) {
        in 0..30 -> println("Reallly Cold")
        in 31..40 -> println("Getting colder")
        in 41..50 -> println("Kind of Cold")
        in 51..60 -> println("Nippy")
        in 71..80 -> println("Just Right")
    }
    val nullableName : String? = null
    val length = nullableName?.length ?: -1
    println(length)

}