/**
 *
 */
fun main(args: Array<String>) {
    fun handleInteger(myInt: Int, operation : (Int) -> Unit) {
        operation(myInt)
    }

    handleInteger(5, { println("My result is ${it*10}") } )

    fun printResult(myInt: Int) { println("myInt is $myInt")}
    handleInteger(5, ::printResult)
}