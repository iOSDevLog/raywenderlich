/**
 *
 */
typealias operation = (Int, Int) -> Int

fun main(args: Array<String>) {
    fun printMultipleOf(multiplier: Int, andValue: Int) {}
    fun printMultipleOf(multiplier: Int, andValue: Int, thirdValue : Int) {}
    fun printMultipleOf(multiplier: Int, andValue: Int, thirdValue : Int, forthValue : Int) {}

    fun getValue() : Int {
        return 31;
    }
/*
    fun getValue() : String {
        return "Kevin Moore"
    }
*/
    fun getStringValue(): String {
        return "Kevin Moory"
    }


    fun incrementAndPrint(value: Int) {
//        value += 1
        print(value)
    }

    fun add( a: Int, b: Int) : Int {
        return a + b
    }

    var function : (Int, Int) -> Int = ::add // 1

    function(4, 2)

    fun subtract(a: Int, b: Int) : Int {
        return a - b
    }

    function = ::subtract // 2

    function(4, 2)

    fun printResult(function: (Int, Int) -> Int, a: Int, b: Int) {
        val result = function(a, b)
        println(result)
    }
    printResult(::add, 4, 2)

    fun printResult2(function: operation, a: Int, b: Int) {}

    fun noReturn() : Unit {
    }

}
