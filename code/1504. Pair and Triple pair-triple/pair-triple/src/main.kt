/**
 *
 */
fun main(args: Array<String>) {
    val coordinates = Pair(2, 3)
    val (x,y) = coordinates
    println("x = $x y= $y")

    println("x = ${coordinates.first} y = ${coordinates.second}")

    val coordinatesDoubles = Pair(2.1, 3.5) // Inferred as doubles
    println("x = ${coordinatesDoubles.first} y = ${coordinatesDoubles.second}")

    val coordinatesMixed = Pair(2.1, 3) // Mixed
    println("x = ${coordinatesMixed.first} y = ${coordinatesMixed.second}")

    val x1 = coordinates.first
    val y1 = coordinates.second
    println("x1 = ${x1} y1 = ${y1}")

    val coordinates3D = Triple(2, 3, 1)
    val (x3, y3, z3) = coordinates3D // Shortcut to pull out each element into a var
    println("x3 = ${x3} y3 = ${y3} z3 = ${z3}")

    val (x4, y4, _) = coordinates3D // Ignore 3rd part
    println("x4 = ${x4} y4 = ${y4}")

}

