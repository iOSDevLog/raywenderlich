/**
 * Create a Shape interface with 2 integer properties named:
 * width, height.
 * Add a function named draw
 */
interface Shape {
    var width : Int
    var height : Int
    fun draw()
}

/**
 * Create a Circle that takes these values in the constructor and implements the Shape
 * Interface
 */
class Circle(override var width: Int, override var height: Int) : Shape {
    override fun draw() {
        println("Drawing a Circle")
    }
}

/**
 * Create a Line that takes these values in the constructor and implements the Shape
 * Interface
 */
class Line(override var width: Int, override var height: Int) : Shape {
    override fun draw() {
        println("Drawing a Line")
    }
}

/**
 * Create a function named printShape that takes a shape and calls the draw method
 */
fun printShape(shape: Shape) {
    shape.draw()
}

/**
 * Create a circle and a line and call printShape on both
 */
fun main(args: Array<String>) {
    val circle = Circle(10, 10)
    val line = Line(10, 10)
    printShape(circle)
    printShape(line)
}
