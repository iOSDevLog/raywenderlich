/**
 *
 */
sealed class Expression

data class Num(val number: Double) : Expression()
data class Sum(val e1: Expression, val e2: Expression) : Expression()
object NotANumber : Expression()

fun eval(expr: Expression): Double = when (expr) {
    is Num -> expr.number
    is Sum -> eval(expr.e1) + eval(expr.e2)
    NotANumber -> Double.NaN
// the `else` clause is not required because we've covered all the cases
}

fun main(args: Array<String>) {
    val num1 = Num(5.5)
    val num2 = Num(10.0)
    println("The Sum of 5.5 + 10.0 = ${eval(Sum(num1, num2))}")
}
